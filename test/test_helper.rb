ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require "faker"
require_relative "support/faker_helper"
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

module ActiveSupport
  class TestCase
    include Devise::Test::IntegrationHelpers
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
    setup :global_setup
    teardown :global_teardown

    # Devise RuntimeError: Could not find a valid mapping for #<User
    ActiveSupport.on_load(:action_mailer) do
      Rails.application.reload_routes_unless_loaded
    end

    def user_with_team
      user = Fabricate(:user_with_team)
      [ user, with_team(user.teams.first) ]
    end

    def with_team(team = nil)
      Current.team = ActsAsTenant.test_tenant = team || Fabricate(:default_team)
    end

    def global_setup
      nil if self.class.skip_global_setup?
    end

    def global_teardown
      nil if self.class.skip_global_setup?
      Current.reset
      ActsAsTenant.test_tenant = nil
    end

    class << self
      attr_accessor :skip_global_flag

      def skip_global_setup?
        skip_global_flag
      end

      def skip_global_setup
        self.skip_global_flag = true
      end
    end
  end
end
