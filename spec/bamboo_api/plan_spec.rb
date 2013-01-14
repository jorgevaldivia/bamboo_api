require 'spec_helper'

describe BambooApi::Plan do

	before( :each ) do
		api = BambooApi.new( {end_point: "example.atlassian.net", username: "jorge@example.com", password: "passwordxxx" } )
	end

	describe "requests" do

		it "should get all plans when calling .all" do
			VCR.use_cassette('plans.all') do
				BambooApi::Plan.all.count.should eq 3
			end
		end

		it "should get a single plan when calling .find" do
			VCR.use_cassette('plans.find') do
				plan = BambooApi::Plan.find( "PHO-UAT" )
				plan.short_name.should eq "Phoenix UAT"
				plan.short_key.should eq "UAT"
			end
		end

	end

	describe "states" do
		# it "should return the readable state for a successful plan" do
		# 	VCR.use_cassette('plans.find') do
		# 		plan = BambooApi::Plan.find( "PHO-UAT" )
		# 		plan.successful?.should eq true
		# 		plan.readable_status.should eq "Phoenix - Phoenix UAT is currently open and it is safe to commit."
		# 	end
		# end
	end
end