# test/support/team_integration_test.rb
class TeamIntegrationTest < ActionDispatch::IntegrationTest
  teardown do
    ActsAsTenant.test_tenant = nil
  end

  # def default_url_options
  #   { team_slug: @team&.slug }.merge(super)
  # end
end
