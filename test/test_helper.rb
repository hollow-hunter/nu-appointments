ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
  include Devise::Test::IntegrationHelpers
  set_fixture_class oauth_applications: Doorkeeper::Application
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def api_sign_in(user)
    app = oauth_applications(:minitest)
    token = Doorkeeper::AccessToken.create!(application_id: app.id, resource_owner_id: user.id)
    token.token
  end
end
