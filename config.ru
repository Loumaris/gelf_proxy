# frozen_string_literal: true

require File.expand_path('lib/boot.rb', __dir__)

require './app'
$stdout.sync = true

run Rack::URLMap.new('/' => SinatraTemplate)
