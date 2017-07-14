ENV['RACK_ENV'] = 'test'

require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require 'capybara'
require 'pry'
require 'rspec'
require 'database_cleaner'
require_relative './web_helpers'
require_relative '../app/app'
require_relative '../app/data_mapper_setup'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

Capybara.app = Centre17Booking

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
