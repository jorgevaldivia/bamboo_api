require 'spec_helper'

describe BambooApi::Build do
  
  describe "parse user info" do
  	before( :each ) do
  		BambooApi::Build.any_instance.stub( :initialize ).and_return true
  		BambooApi::Build.any_instance.stub( :build_reason ).and_return 'Changes by <a href="https://example.com/builds/browse/user/john.doe@example.com">John Doe</a>'
  	end

  	it "should parse out the username from the build reason" do
  		BambooApi::Build.new.parse_username.should eq "John Doe"
  	end

  	it "should parse out the user's url from the build reason" do
  		BambooApi::Build.new.parse_user_url.should eq "https://example.com/builds/browse/user/john.doe@example.com"
  	end

  	it "should return nil if the build reason is blank" do
  		BambooApi::Build.any_instance.stub( :build_reason ).and_return ""
  		BambooApi::Build.new.parse_user_url.should eq nil
  	end
  end


end