require 'spec_helper'

describe BambooApi::Build do

	before( :each ) do
		api = BambooApi.new( {end_point: "example.atlassian.net", username: "jorge@example.com", password: "passwordxxx" } )
	end
  
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

  describe "retrieve" do
  	it "should get all builds when calling .find_by_plan" do
			VCR.use_cassette('builds.find_by_plan') do
				BambooApi::Build.find_by_plan( "PHO-UAT" ).count.should eq 25
			end
		end

		it "should get a single build when calling .find" do
			VCR.use_cassette('builds.find') do
				build = BambooApi::Build.find( "PHO-UAT-2100" )
				build.key.should eq "PHO-UAT-2100"
				build.plan_name.should eq "Phoenix UAT"
			end
		end
  end

  describe "stages" do
  	it "should return the failing stage if the build failed" do
  		VCR.use_cassette('builds.find.failing') do
				failing_build = BambooApi::Build.find( "PHO-CUAT-257" )
				failing_build.failing_stage.nil?.should eq false
				failing_build.failing_stage.id.to_s.should eq "14516313"
			end
  	end
  end

  describe "state" do
  	it "failed? should return true if the build failed" do
			VCR.use_cassette('builds.find.failing') do
				failing_build = BambooApi::Build.find( "PHO-CUAT-257" )
				failing_build.failed?.should eq true
				failing_build.successful?.should eq false
			end
  	end

  	it "successful? should return true if the build failed" do
			VCR.use_cassette('builds.find') do
				build = BambooApi::Build.find( "PHO-UAT-2100" )
				build.successful?.should eq true
				build.failed?.should eq false
			end
  	end
  end

end