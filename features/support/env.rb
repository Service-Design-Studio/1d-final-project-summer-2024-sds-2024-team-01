# Simplecov for cucumber and capybara
require 'simplecov'
SimpleCov.start 'rails' do
    add_filter 'app/mailers'
    add_filter 'app/jobs'
    add_filter 'app/channels'
    add_filter 'app/controllers/my_devise'
end

require 'cucumber/rails'
require 'capybara/cucumber'
require 'selenium-webdriver'

# Use the default Rails driver for Capybara
Capybara.default_driver = :selenium
Capybara.app_host = 'http://localhost:3000'

# Configure DatabaseCleaner to ensure a clean state for each test
begin
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean_with(:truncation)
rescue NameError
  raise 'You need to add database_cleaner-active_record to your Gemfile (in the :test group) if you wish to use it.'
end

Before do |scenario|
    load Rails.root.join('db/seeds.rb')
end
# Before each scenario, start a transaction
Cucumber::Rails::Database.javascript_strategy = :truncation
