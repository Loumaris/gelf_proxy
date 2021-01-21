# frozen_string_literal: true

SERVER_ENCODING = 'UTF-8'
# APP Name
APP_NAME = ENV['APP_NAME'] || 'gelf proxy'
# LOG Server
LOG_SERVER = ENV['LOG_SERVER'] || ''
LOG_SERVER_PORT = (ENV['LOG_SERVER_PORT'] || 12201).to_i
LOGGER_USERNAME = ENV['LOGGER_USERNAME'] || 'gelf'
LOGGER_PASSWORD = ENV['LOGGER_PASSWORD'] || 'fleg'
