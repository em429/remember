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

# There is another login helper defined for system tests in application_system_test_case.rb
# called capybara_log_in_as()
class ActionDispatch::IntegrationTest
  def log_in_as(user, password: 'asdf1234')
    post session_url(email: user.email, password: password)
    assert_equal "Welcome back, #{user.username}!", flash[:notice]
  end
end

