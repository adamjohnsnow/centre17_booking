ENV['RACK_ENV'] = 'test'

require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require 'capybara'
require 'pry'
require 'rspec'
require 'database_cleaner'
require_relative '../app'
require_relative '../data_mapper_setup'

DatabaseCleaner.strategy = :truncation

Capybara.app = Centre17Booking

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
