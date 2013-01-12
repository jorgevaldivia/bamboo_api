class BambooApi::Build

	# /result/PHO-UAT	
	attr_reader :restartable, :once_off, :continuable, :id, :number, :life_cycle_state, :state, :key,
		:link, :plan_name, :project_name, :build_started_time, :build_completed_time, :build_duration_in_seconds,
		:revision, :vcs_revision_key, :build_test_summary, :successful_test_count, :failed_test_count,
		:quarantined_test_count, :build_reason, :user_url, :username, :stages

	def initialize restartable, once_off, continuable, id, number, life_cycle_state, state, key,
		link, plan_name, project_name, build_started_time, build_completed_time, build_duration_in_seconds,
		vcs_revision_key, build_test_summary, successful_test_count, failed_test_count,
		quarantined_test_count, build_reason, stages

		@restartable = restartable
		@once_off = once_off
		@continuable = continuable
		@id = id
		@number = number
		@life_cycle_state = life_cycle_state
		@state = state
		@key = key
		@link = link
		@plan_name = plan_name
		@build_started_time = build_started_time
		@build_completed_time = build_completed_time
		@build_duration_in_seconds = build_duration_in_seconds
		@revision = @vcs_revision_key = vcs_revision_key
		@build_test_summary = build_test_summary
		@successful_test_count = successful_test_count
		@failed_test_count = failed_test_count
		@quarantined_test_count = quarantined_test_count
		@build_reason = build_reason
		@user_url = user_url
		@username = username
		@stages = stages

		@user_url = parse_user_url
		@username = parse_username
	end

	def parse_username
		self.build_reason.scan(/>(.*)</).flatten.first if !build_reason.nil? && !build_reason.empty?
	end

	def parse_user_url
		self.build_reason.scan(/href="(.*)"/).flatten.first if !build_reason.nil? && !build_reason.empty?
	end

	def self.parse builds
		parsed_builds = []

		builds[ "results" ][ "result" ].each do | build |
			parsed_builds.push( BambooApi::Build.parse_single( build ) )
		end

		parsed_builds
	end


	def self.parse_single build
		stages = BambooApi::Stage.parse( build[ "stages" ] )
		BambooApi::Build.new build[ "restartable" ], build[ "onceOff" ], build[ "continuable" ], build[ "id" ], build[ "lifeCycleState" ],
			build[ "state" ], build[ "key" ], build[ "link" ], build[ "planName" ], build[ "projectName" ], build[ "buildStartedTime" ], 
			build[ "buildCompletedTime" ], build[ "buildDurationInSeconds" ], build[ "vcsRevisionKey" ], build[ "buildTestSummary" ], 
			build[ "successfulTestCount" ], build[ "failedTestCount" ], build[ "quarantinedTestCount" ], build[ "buildReason" ], stages
	end

	def self.all
		raise "You must use the method find_by_plan. Sorry."
	end

	def self.find key
		BambooApi::Build.parse_single( BambooApi.request "build/#{key}" )
	end

	def find_by_plan plan_key
		BambooApi::Build.parse( BambooApi.request "result/#{plan_key}" )
	end
end
