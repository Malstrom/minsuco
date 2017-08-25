source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.0'
gem 'mysql2'
gem 'puma', '~> 3.7'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

gem 'sass-rails', '~> 5.0.1'  # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'    # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.2'  # Use CoffeeScript for .coffee assets and views
gem 'jbuilder', '~> 2.5'      # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "bower-rails", "~> 0.9.2"
gem "slim-rails"

# gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password

gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

gem 'omnicontacts', :git => 'https://github.com/Diego81/omnicontacts.git' # import google contacts

gem 'acts_as_tree'  # category as tree

gem 'sendgrid-ruby' # send email trough sendgrind

gem 'cancancan', '~> 2.0'

gem "chartkick"       # simply charts
gem 'groupdate'       # with chartkick charts are very simply

# gem 'paper_trail'   # Track changes to your models' data. Good for auditing or versioning.
# gem 'active_admin'  # elegant backends for website administration

gem 'faker'           # fake data

gem 'payola-payments', git: 'https://github.com/Malstrom/payola.git'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # check security of app
  gem 'brakeman', :require => false
  # create entity reltional diagram
  gem 'rails-erd', "1.5.0", require: false
end

group :test do
  gem 'rspec'

  #test with features
  gem "cucumber"
  gem 'cucumber-rails', :require => false
  gem 'capybara'

  # test with browser behavior with chrome
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'

  # Database for test
  gem 'factory_girl_rails'
  gem 'database_cleaner'

  #code coverage
  gem 'simplecov'

  #additional steps for test email mainly
  gem 'email_spec'
  gem 'pickle'
  gem 'action_mailer_cache_delivery'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# new gems to test

# gem 'ransack', github: 'activerecord-hackery/ransack' #search
# gem 'searchkick #search #elasticsearch
# gem "slack-notifier"