class BambooApi::Project
	
	attr_reader :link, :key, :name

	def initialize link, key, name
		@link = link
		@key = key
		@name = name
	end

	def self.parse project
		parsed_projects = []

		projects[ "projects" ][ "project" ].each do | project |
			parsed_projects.push( BambooApi::Project.parse_single( project ) )
		end

		parsed_projects
	end

	def self.parse_single projects
		BambooApi::Project.new project[ "link" ], project[ "key" ], project[ "name" ]
	end
end