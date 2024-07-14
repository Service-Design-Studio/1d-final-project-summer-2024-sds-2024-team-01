# We are not using rails test to test our application
#
# require 'simplecov'
# SimpleCov.start
#
# # ENV["RAILS_ENV"] ||= "test"
# # require_relative "../config/environment"
# # require "rails/test_help"
# if ENV['RAILS_ENV'] == 'test'
#   require 'simplecov'
#   SimpleCov.start 'rails'
#   puts "required simplecov"
# end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
