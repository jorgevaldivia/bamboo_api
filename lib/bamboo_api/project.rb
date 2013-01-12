class BambooApi::Project
	
	attr_reader :link, :key, :name

	def initialize link, key, name
		@link = link
		@key = key
		@name = name
	end

	def self.parse projects
		parsed_projects = []

		projects[ "projects" ][ "project" ].each do | project |
			parsed_projects.push( BambooApi::Project.parse_single( project ) )
		end

		parsed_projects
	end

	def self.parse_single project
		BambooApi::Project.new project[ "link" ], project[ "key" ], project[ "name" ]
	end

	def self.all
		BambooApi::Project.parse( BambooApi.request "project" )
	end

	def self.find key
		BambooApi::Project.parse_single( BambooApi.request "project/#{key}" )
	end
end