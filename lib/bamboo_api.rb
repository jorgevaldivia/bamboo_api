require "bamboo_api/version"
require "bamboo_api/plan"
require "bamboo_api/project"
require "rest_client"
require 'open-uri'
require 'json'

class BambooApi

  def initialize options={}
  	@end_point = options[ :end_point ]
  	@username = options[ :username ]
  	@password = options[ :password ]
  end

  def plans
  	BambooApi::Plan.parse( self.request "plan" )
  end

  def projects
  	BambooApi::Project.parse( self.request "project" )
  end

  protected

  def compose_url action
  	"https://#{@end_point}/builds/rest/api/latest/#{action}.json?os_authType=basic&os_username=#{URI::encode( @username )}&os_password=#{URI::encode( @password )}"
  end

  def request action
  	JSON.parse( RestClient.get( compose_url( action ) ) )
  end
end
