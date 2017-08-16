source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.0'

gem 'mysql2'

gem 'acts_as_tree'

# Use Puma as the app server
gem 'puma', '~> 3.7'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem "bower-rails", "~> 0.9.2"

# auth/auth
gem 'devise'

gem 'omniauth-facebook'

gem 'omniauth-google-oauth2'
gem 'omnicontacts', :git => 'https://github.com/Diego81/omnicontacts.git'

gem 'cancancan', '~> 2.0'

gem "responders" # flash messages via i18n

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Adds support for Capybara system testing and selenium driver
end

gem 'faker'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem "better_errors"
  gem "binding_of_caller"
  # gem 'brakeman', :require => false
  gem 'rails-erd', require: false
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem "cucumber"
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'rspec'
  gem 'chromedriver-helper'
  gem 'webrat'
  gem 'factory_girl_rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'payola-payments', git: 'https://github.com/Malstrom/payola.git'

# ----

gem 'wicked'

# gem 'public_activity'

gem "nested_form"

# gem 'paper_trail' # Track changes to your models' data. Good for auditing or versioning.
# gem 'active_admin' # elegant backends for website administration

gem "slim-rails"


# new gems to test

# gem 'ransack', github: 'activerecord-hackery/ransack' #search
# gem 'searchkick #search #elasticsearch
# gem "slack-notifier"
gem "chartkick"
gem 'groupdate'
