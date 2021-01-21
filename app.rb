# frozen_string_literal: true

require 'sinatra/base'

unless ENV['RACK_ENV'] == 'production'
  require "sinatra/reloader"
  require 'pry'
end

class SinatraTemplate < Sinatra::Base
  before do
    content_type :json
  end

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
