source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# BASIC
gem 'rails', '5.1.1'
gem 'mysql2', '~> 0.3.18'
gem 'puma', '~> 3.7'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# RouteTranslator is a gem to allow you to manage the translations of your app routes with a simple dictionary format.
gem 'route_translator'

gem "bower-rails", "~> 0.9.2"
gem 'sass-rails', '~> 5.0.1'  # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'    # Use Uglifier as compressor for JavaScript assets

gem 'coffee-rails', '~> 4.2'  # Use CoffeeScript for .coffee assets and views
gem "slim-rails"

gem 'jbuilder', '~> 2.5'      # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

#auth
gem 'devise'
gem "omniauth"
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
# gem 'doorkeeper'

#
gem 'omnicontacts', :git => 'https://github.com/Diego81/omnicontacts.git' # import google contacts
gem 'cancancan', '~> 2.0'
# gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password

#improvement
gem 'acts-as-taggable-on', '~> 4.0' # for tag categories to users
gem 'acts_as_tree'  # category as tree
gem 'paper_trail'   # Track changes to your models' data. Good for auditing or versioning.
gem 'goldiloader'   # Automatic ActiveRecord eager loading to reduce the number of database queries run by your application.
gem 'activerecord-session_store'
gem 'activerecord-import' #to solve n+1 sql insert.

#view
gem 'social-share-button'
gem "nested_form"

#Charts
gem "chartkick"
gem 'groupdate'
gem 'active_median'
gem 'hightop'

#app_implementation
gem 'sendgrid-ruby' # send email trough sendgrind
# gem 'payola-payments', git: 'https://github.com/alekseenko/payola'
gem 'payola-payments', git: 'https://github.com/payolapayments/payola.git'
# gem 'payola-payments', git: 'https://github.com/Malstrom/payola.git'
gem 'carrierwave'
gem 'cloudinary'

#tools
gem 'faker' # fake data

gem 'wrenchmode-rack' #
# gem "slack-notifier"


# gem 'gon'
# new gems to test

# gem 'ransack', github: 'activerecord-hackery/ransack' #search
# gem 'searchkick #search #elasticsearch


# gem "state_machines-activerecord"
# gem 'aasm'
# gem 'formulaic', group: :test
# gem 'globalize' # Rails I18n de-facto standard library for ActiveRecord model/data translation.
# gem 'active_admin'  # elegant backends for website administration

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # check security of app
  gem 'brakeman', :require => false
  # create entity reltional diagram
  gem 'rails-erd', "1.5.0", require: false
  gem 'meta_request'
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