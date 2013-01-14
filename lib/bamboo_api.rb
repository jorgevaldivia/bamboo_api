require "bamboo_api/version"
require "bamboo_api/plan"
require "bamboo_api/project"
require "bamboo_api/build"
require "bamboo_api/stage"

require "rest_client"
require 'open-uri'
require 'json'

class BambooApi

  def initialize options={}
    @@end_point = options[ :end_point ]
    @@username = options[ :username ]
    @@password = options[ :password ]
  end

  def self.compose_url action, expand=nil
    url = "https://#{@@end_point}/builds/rest/api/latest/#{action}.json?os_authType=basic&os_username=#{URI::encode( @@username )}&os_password=#{URI::encode( @@password )}"
    url += "&expand=#{expand}"
    url
  end

  def self.request action, expand=nil
    JSON.parse( RestClient.get( BambooApi.compose_url( action, expand ) ) )
  end

end
