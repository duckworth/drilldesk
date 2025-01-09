ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "faker"

module ActiveSupport
  class TestCase
    include Devise::Test::IntegrationHelpers
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
    setup :global_setup
    # Devise RuntimeError: Could not find a valid mapping for #<User
    ActiveSupport.on_load(:action_mailer) do
      Rails.application.reload_routes_unless_loaded
    end
    def global_setup
      # stuff to run before _every_ test.
      @default_team = Fabricate(:default_team)
      ActsAsTenant.test_tenant = @default_team
      # puts "global setup  ActsAsTenant.current_tenant #{ ActsAsTenant.current_tenant&.inspect}"
    end
    # Add more helper methods to be used by all tests here...
  end
end
