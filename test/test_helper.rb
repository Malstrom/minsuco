require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
include Warden::Test::Helpers


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include Warden::Test::Helpers

  # Add more helper methods to be used by all tests here...
end

# RSpec.configure do |config|
#   config.use_transactional_fixtures = false
# end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

# RSpec.configure do |config|
#   config.use_transactional_fixtures = false
# end