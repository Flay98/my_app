ENV["RAILS_ENV"] ||= "test"

begin
  require "simplecov"
  SimpleCov.start "rails" do
    add_filter "/test/"
  end
rescue LoadError
  # SimpleCov is optional until the gem is installed.
end

require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    fixtures :all
  end
end

module AuthenticationTestHelper
  def sign_in_as(user, password: "password")
    post signin_path(locale: :ru), params: {
      session: {
        email: user.email,
        password: password
      }
    }
  end
end

class ActionDispatch::IntegrationTest
  include AuthenticationTestHelper
end
