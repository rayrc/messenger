require 'httparty'
require 'json'

module Messenger

  class Campfire

    def self.send(url, body, options={})
      api_key, room, subdomain = url.match(/^campfire:\/\/([^:]+):([^@]+)@([^\.]+)/)[1,3]
      HTTParty.post(
        "http://#{subdomain}.campfirenow.com/room/#{room}/speak.json",
        :basic_auth => { :username => api_key, :password => "x" },
        :headers => { "Content-Type" => "application/json" },
        :body => { "message" => { "body" => body } }.to_json
      )
    end

  end

end
