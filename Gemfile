# Gemfile

source "https://rubygems.org"

ruby "3.2.4"

gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# for error loggin and static assets
gem 'rails_12factor'

# SCSS Supremacy
gem 'sass-rails', "~> 6.0.0"

#Imma be real idk what uglifier is but wtv 
gem 'uglifier', "~> 4.2.0"

#It doesn't work without this
gem "bootsnap", require: false

# Support for Windows
gem 'tzinfo', '~> 2.0.6'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

gem 'pg', '~> 1.5.6'

gem 'google-cloud-storage', '~> 1.47', require: false

# for geospatial queries from the database to query for locations
gem 'rgeo', '~> 3.0.1'
gem 'activerecord-postgis-adapter', '~> 9.0.2'
gem 'active_storage_validations'

# for authentication; to make user accounts
gem 'devise'

# for role management and belongs_to
gem 'rolify'

group :development do
  gem 'web-console', '~> 4.2.1'
end

group :development, :test do
  gem 'rails-controller-testing'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner-active_record'
  gem 'selenium-webdriver'
  gem 'capybara', '~> 3.40.0'
  gem 'rspec-rails', '~> 6.1.2'
  gem 'guard-rspec', '~> 4.7.3'
  gem 'simplecov', require: false
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'guard-cucumber'
  gem 'guard'
end

group :production do
end

#byebug
gem 'byebug', '~> 11.1', '>= 11.1.3'

gem 'puma' # Puma is the default server for Rails

gem 'faker'

gem 'shoulda-matchers', '~> 5.0'

#gem 'ruby-vips' #enable image analysis
