# frozen_string_literal: true

require 'sinatra/base'
require "sinatra/config_file"

unless ENV['RACK_ENV'] == 'production'
  require "sinatra/reloader"
  require 'pry'
end

class SinatraTemplate < Sinatra::Base
  before do
    content_type :json
  end

  register Sinatra::ConfigFile
  config_file 'config/proxy.yml'
  #############################################################################
  # load configuration from ENV or file or default
  #############################################################################
  APP_NAME = ENV['APP_NAME'] || settings.app_name || 'gelf proxy'
  LOG_SERVER = ENV['LOG_SERVER'] || settings.log_server || ''
  LOG_SERVER_PORT = (ENV['LOG_SERVER_PORT']|| settings.log_server_port || 12201).to_i
  LOGGER_USERNAME = ENV['LOGGER_USERNAME']|| settings.logger_username || 'gelf'
  LOGGER_PASSWORD = ENV['LOGGER_PASSWORD']|| settings.logger_password || 'fleg'

  #############################################################################
  # production env settings, force ssl and auth
  #############################################################################
  if ENV['RACK_ENV'] == 'production'
    use Rack::SSL # force SSL
    use Rack::Auth::Basic, 'Protected Area' do |username, password|
      username == LOGGER_USERNAME && password == LOGGER_PASSWORD
    end
  else
    register Sinatra::Reloader
    also_reload 'lib/*'
  end

  #############################################################################
  # index
  #############################################################################
  get '/' do
    { hello: "world" }.to_json
  end

  #############################################################################
  # log
  #############################################################################
  post '/log' do
    logger = GELF::Logger.new(LOG_SERVER, LOG_SERVER_PORT, "WAN", { facility: APP_NAME })
    logger << request.body.read

    { }.to_json
  end


  ## Run the app when file called ##
  run! if $PROGRAM_NAME == __FILE__
end
