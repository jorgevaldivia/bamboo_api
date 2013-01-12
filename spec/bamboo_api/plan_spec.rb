require 'spec_helper'

describe BambooApi::Plan do

	describe "requests" do

		it "should get all plans when calling .all" do
			VCR.use_cassette('plans.all') do
				api = BambooApi.new( {end_point: "example.atlassian.net", username: "jorge@example.com", password: "passwordxxx" } )
				puts BambooApi::Plan.all.count.should eq 3
			end
		end

		it "should get a single plan when calling .find" do
			VCR.use_cassette('plans.find') do
				api = BambooApi.new( {end_point: "example.atlassian.net", username: "jorge@example.com", password: "passwordxxx" } )
				plan = BambooApi::Plan.find( "PHO-UAT" )
				plan.short_name.should eq "MyApp UAT"
				plan.short_key.should eq "UAT"
			end
		end

	end
end