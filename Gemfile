# Gemfile

source "https://rubygems.org"

ruby "3.2.4"

gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# SCSS Supremacy
gem 'sass-rails'

#Imma be real idk what uglifier is but wtv 
gem 'uglifier'

#It doesn't work without this
gem "bootsnap", require: false

# Support for Windows
gem 'tzinfo'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

gem 'pg'

# for geospatial queries from the database to query for locations
gem 'rgeo'
gem 'activerecord-postgis-adapter'

group :development do
  gem 'web-console'
end
group :development, :test do
  gem 'cucumber'
  gem 'capybara'
  gem 'rspec-rails'
  gem 'guard-rspec'
end

group :production do
end


