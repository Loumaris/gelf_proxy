# frozen_string_literal: true

require File.expand_path('lib/boot.rb', __dir__)

require './app'
$stdout.sync = true

subpath = ENV['SUBPATH_URI'] || '/'

run Rack::URLMap.new(subpath => SinatraTemplate)
