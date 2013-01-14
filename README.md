# BambooApi

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'bamboo_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bamboo_api

## Usage

Initialization

		BambooApi.new( {end_point: "example.atlassian.net", username: "jorge@example.com", password: "password" } )

Projects

		puts BambooApi::Project.all
		puts BambooApi::Project.find( "KEY" )

Plans

		BambooApi::Plan.all
		BambooApi::Plan.find( "PLANKEY" )
		BambooApi::Plan.find( "PLANKEY" ).builds
		BambooApi::Plan.find( "PLANKEY" ).building?
		BambooApi::Plan.find( "PLANKEY" ).readable_status 

Builds

	BambooApi::Build.find( "BUILDID" )
	BambooApi::Build.find_by_plan( "PLANKEY" )
	BambooApi::Build.find( "BUILDID" ).stages
	BambooApi::Build.find( "BUILDID" ).status
	BambooApi::Build.find( "BUILDID" ).failing_stage # Return the failing stage if the status if failing

Note that there is no 'all' method for builds, as the Bamboo API requires a plan key.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
