class BambooApi::Build

	# /result/PHO-UAT	
	attr_reader :restartable, :once_off, :continuable, :id, :number, :life_cycle_state, :state, :key,
		:link, :plan_name, :project_name, :build_started_time, :build_completed_time, :build_duration_in_seconds
		:revision, :vcs_revision_key, :build_test_summary, :successful_test_count, :failed_test_count,
		:quarantined_test_count, :build_reason, :user_url, :username, :stages

	def initialize restartable, once_off, continuable, id, number, life_cycle_state, state, key,
		link, plan_name, project_name, build_started_time, build_completed_time, build_duration_in_seconds
		vcs_revision_key, build_test_summary, successful_test_count, failed_test_count,
		quarantined_test_count, build_reason, user_url, username, stages

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
	end

	def parse_username
		""
	end

	def parse_user_url
		""
	end

	def self.parse builds
		parsed_builds = []

		builds[ "results" ][ "result" ].each do | build |
			parsed_builds.push( BambooApi::Build.parse_single( build ) )
		end

		parsed_builds
	end

	def self.parse_single build
		@stages = BambooApi::Stage.parse( build[ "stages" ] )
		BambooApi::Build.new build[ "link" ], build[ "key" ], build[ "name" ]
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

# <result restartable="false" onceOff="false" continuable="false" id="14483589" number="2100" lifeCycleState="Finished" state="Successful" key="PHO-UAT-2100" expand="vcsRevisions,artifacts,comments,labels,jiraIssues,stages">
# <link rel="self" href="https://mcfina.atlassian.net/builds/rest/api/latest/result/PHO-UAT-2100"/>
# <planName>Phoenix UAT</planName>
# <projectName>Phoenix</projectName>
# <buildStartedTime>2013-01-11T16:10:03.304-05:00</buildStartedTime>
# <buildCompletedTime>2013-01-11T16:51:58.135-05:00</buildCompletedTime>
# <buildDurationInSeconds>2514</buildDurationInSeconds>
# <buildRelativeTime>5 hours ago</buildRelativeTime>
# <vcsRevisionKey>2216</vcsRevisionKey>
# <buildTestSummary>No tests found</buildTestSummary>
# <successfulTestCount>0</successfulTestCount>
# <failedTestCount>0</failedTestCount>
# <quarantinedTestCount>0</quarantinedTestCount>
# <buildReason>
# Changes by <a href="https://mcfina.atlassian.net/builds/browse/user/luis.ezcurdia@softwareallies.com">Luis Ezcurdia</a>
# </buildReason>
# <stages expand="stage" size="5" max-result="5" start-index="0">

# </stages>
# </result>