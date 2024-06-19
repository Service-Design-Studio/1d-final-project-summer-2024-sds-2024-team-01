# features/support/env.rb
require 'cucumber/rails'
require 'capybara/cucumber'

# Optional: If you are using Selenium WebDriver
Capybara.default_driver = :selenium_chrome

# Set the default browser (optional)
Capybara.javascript_driver = :selenium_chrome

# Ensure DatabaseCleaner is configured
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation
