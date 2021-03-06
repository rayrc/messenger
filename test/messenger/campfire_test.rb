require "test_helper"

class Messenger::CampfireTest < Test::Unit::TestCase

  context "Campfire notification" do
    setup do
      @success_response = stub(:code => 200)
      @failure_response = stub(:code => 500)
    end

    should "post a successful message" do
      HTTParty.expects(:post).with("http://subdomain.campfirenow.com/room/room/speak.json", :basic_auth => {:username => 'api', :password => 'x'}, :body => '{"message":{"body":"content"}}', :headers => { "Content-Type" => "application/json"}).returns(@success_response)
      result = Messenger::Campfire.deliver("campfire://api:room@subdomain.campfirenow.com", 'content')
      assert result.success?
      assert_equal @success_response, result.response
    end

    should "post to secure URL" do
      HTTParty.expects(:post).with("https://subdomain.campfirenow.com/room/room/speak.json", :basic_auth => {:username => 'api', :password => 'x'}, :body => '{"message":{"body":"content"}}', :headers => { "Content-Type" => "application/json"}).returns(@success_response)
      result = Messenger::Campfire.deliver("campfire-ssl://api:room@subdomain.campfirenow.com", 'content')
      assert result.success?
      assert_equal @success_response, result.response
    end

    should "post a failed message" do
      HTTParty.expects(:post).with("http://subdomain.campfirenow.com/room/room/speak.json", :basic_auth => {:username => 'api', :password => 'x'}, :body => '{"message":{"body":"content"}}', :headers => { "Content-Type" => "application/json"}).returns(@failure_response)
      result = Messenger::Campfire.deliver("campfire://api:room@subdomain.campfirenow.com", 'content')
      assert_equal false, result.success?
      assert_equal @failure_response, result.response
    end

    should "raise when sending to an invalid URL" do
      assert_raises Messenger::URLError do
        Messenger::Campfire.deliver("campfire://missing_room@subdomain.campfirenow.com", 'content')
      end
    end

    should "obfuscate the URL" do
      assert_equal "campfire://xxxx:1234@example.campfirenow.com", Messenger::Campfire.obfuscate("campfire://asdf1234:1234@example.campfirenow.com")
    end

    should "obfuscate a secure URL" do
      assert_equal "campfire-ssl://xxxx:1234@example.campfirenow.com", Messenger::Campfire.obfuscate("campfire-ssl://asdf1234:1234@example.campfirenow.com")
    end

    should "raise when obfuscating an invalid URL" do
      assert_raises Messenger::URLError do
        Messenger::Campfire.obfuscate("campfire://missing_room@subdomain.campfirenow.com")
      end
    end
  end

  context "Campfire URL validation" do
    should "return true for good URLs" do
      assert_equal true, Messenger::Campfire.valid_url?("campfire://api_key:room@subdomain.campfirenow.com")
      assert_equal true, Messenger::Campfire.valid_url?("campfire-ssl://api_key:room@subdomain.campfirenow.com")
    end

    should "return false for bad URLs" do
      assert_equal false, Messenger::Campfire.valid_url?("campfire://!")
      assert_equal false, Messenger::Campfire.valid_url?("campfire://api_key@subdomain.campfirenow.com")
      assert_equal false, Messenger::Campfire.valid_url?("campfire://:room@subdomain.campfirenow.com")
      assert_equal false, Messenger::Campfire.valid_url?("campfire://api_key:room@subdomain")
      assert_equal false, Messenger::Campfire.valid_url?("campfire://api_key:room@campfirenow.com")
    end
  end

end
