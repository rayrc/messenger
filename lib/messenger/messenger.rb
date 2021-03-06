require 'base64'

module Messenger

  def self.valid_url?(url)
    service_handler = handler(url)
    service_handler.valid_url?(url)
  rescue ProtocolError
    false
  end

  def self.deliver(url, message, options={})
    service_handler = handler(url)
    if defined?(SystemTimer) && SystemTimer.respond_to?(:timeout_after)
      SystemTimer.timeout_after(options[:timeout] || 15) do
        service_handler.deliver(url, message, options)
      end
    else
      Timeout.timeout(options[:timeout] || 15) do
        service_handler.deliver(url, message, options)
      end
    end
  end

  def self.obfuscate(url)
    service_handler = handler(url)
    service_handler.obfuscate(url)
  end


  def self.protocol(url)
    # TODO: More services
    #   sms://1231231234
    #   twitter://username
    #   aim://username
    case url
    when /\Ahttp/ then      :http
    when /\Acampfire/ then  :campfire
    when /\Aslack/ then     :slack
    when /\Ajabber/ then    :jabber
    when /\Amailto|@+/ then :email
    end
  end

  def self.handler(url)
    case protocol(url)
    when :email then    Messenger::Email
    when :http then     Messenger::Web
    when :campfire then Messenger::Campfire
    when :jabber then   Messenger::Jabber
    when :slack then    Messenger::Slack
    else
      raise Messenger::ProtocolError, "Malformed service URL: #{url}. Either this syntax is wrong or this service type is not yet implemented."
    end
  end

  def self.basic_auth(user, password)
    encoded_credentials = ["#{user}:#{password}"].pack("m*").gsub(/\n/, '')
    {"HTTP_AUTHORIZATION" => "Basic #{encoded_credentials}"}
  end

end
