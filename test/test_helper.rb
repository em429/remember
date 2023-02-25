ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Remove all test fixtures during teardown
  parallelize_teardown do |i|
    FileUtils.rm_rf(ActiveStorage::Blob.services.fetch(:test_fixtures).root)
  end
  
end

module SignInHelper
  def sign_in_as(user)
    post session_url(email: user.email, password: "asdf1234")
    # TODO: add assert for flash: Welcome back #{user}
  end
end

class ActionDispatch::IntegrationTest
  include SignInHelper
end
