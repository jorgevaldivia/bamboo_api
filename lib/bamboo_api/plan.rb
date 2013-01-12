class BambooApi::Plan
	
	# {"shortName"=>"Phoenix Customer UAT", "shortKey"=>"CUAT", "type"=>"chain", "enabled"=>true, "link"=>{"href"=>"https://mcfina.atlassian.net/builds/rest/api/latest/plan/PHO-CUAT", "rel"=>"self"}, "key"=>"PHO-CUAT", "name"=>"Phoenix - Phoenix Customer UAT"}

	attr_reader :short_name, :short_key, :type, :enabled, :link, :key, :name

	def initalize short_name, short_key, type, enabled, link, key, name
		@short_name = short_name
		@short_key = short_key
		@type = type
		@enabled = enabled
		@link = link
		@key = key
		@name = name
	end

	def self.parse plans
		parsed_plans = []

		plans[ "plans" ][ "plan" ].each do | plan |
			parsed_plans.push( BambooApi::Plan.parse_single( plan ) )
		end

		parsed_plans
	end

	def self.parse_single plan
		BambooApi::Plan.new plan[ "shortName" ], plan[ "shortKey" ], plan[ "type" ], 
			plan[ "enabled" ], plan[ "link" ], plan[ "key" ], plan[ "name" ]
	end
end