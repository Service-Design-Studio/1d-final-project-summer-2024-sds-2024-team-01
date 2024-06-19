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

# for geospatial queries from the database to query for locations
gem 'rgeo', '~> 3.0.1'
gem 'activerecord-postgis-adapter', '~> 9.0.2'

group :development do
  gem 'web-console', '~> 4.2.1'
end

group :development, :test do
  gem 'cucumber-rails'
  gem 'capybara', '~> 3.40.0'
  gem 'rspec-rails', '~> 6.1.2'
  gem 'guard-rspec', '~> 4.7.3'
end

group :production do
end

#byebug
gem 'byebug', '~> 11.1', '>= 11.1.3'
