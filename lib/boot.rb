# frozen_string_literal: true

require 'json'
require 'logger'
Dir.glob('./{config,lib}/*.rb').sort.each { |file| require file }
