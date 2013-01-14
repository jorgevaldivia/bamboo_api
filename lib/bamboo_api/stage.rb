class BambooApi::Stage

	attr_reader :restartable, :manual, :collapsed_by_default, :display_message, :display_class, :life_cycle_state, 
		:state, :id, :name, :description

	def initialize restartable, manual, collapsed_by_default, display_message, display_class, life_cycle_state,
		state, id, name, description

		@restartable = restartable
		@manual = manual
		@collapsed_by_default = collapsed_by_default
		@display_message = display_message
		@display_class = display_class
		@life_cycle_state = life_cycle_state
		@state = state
		@id = id
		@name = name
		@description = description
	end

	def successful?
		self.state == "Successful"
	end

	def failed?
		self.state == "Failed"
	end

	def self.parse stages
		parsed_stages = []
		stages[ "stages" ][ "stage" ].each do | stage |
			parsed_stages.push( BambooApi::Stage.parse_single( stage ) )
		end

		parsed_stages
	end

	def self.parse_single stage
		BambooApi::Stage.new stage[ "restartable" ], stage[ "manual" ], stage[ "collapsedByDefault" ], stage[ "displayMessage" ],
			stage[ "displayClass" ], stage[ "lifeCycleState" ], stage[ "state" ], stage[ "id" ], stage[ "name" ], stage[ "description" ]
	end
end