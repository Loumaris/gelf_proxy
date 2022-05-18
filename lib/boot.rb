# frozen_string_literal: true

require 'json'
require 'logger'
require 'rack/ssl'
Dir.glob('./{config,lib}/*.rb').sort.each { |file| require file }
