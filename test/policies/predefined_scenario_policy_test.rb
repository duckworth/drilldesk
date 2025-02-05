# test/policies/predefined_scenario_policy_test.rb
require "test_helper"

class PredefinedScenarioPolicyTest < ActiveSupport::TestCase
  def setup
    @system_user = Fabricate(:sysadmin_user)
    @regular_user = Fabricate(:user)
    @scenario = Fabricate(:predefined_scenario)
  end

  def test_scope
    policy_scope = PredefinedScenarioPolicy::Scope.new(@regular_user, PredefinedScenario).resolve
    assert_equal PredefinedScenario.all, policy_scope
  end

  def test_show
    policy = PredefinedScenarioPolicy.new(@regular_user, @scenario)
    assert policy.show?, "Regular user should be allowed to show the scenario"

    policy_system = PredefinedScenarioPolicy.new(@system_user, @scenario)
    assert policy_system.show?, "System user should be allowed to show the scenario"
  end

  def test_create
    policy = PredefinedScenarioPolicy.new(@regular_user, PredefinedScenario.new)
    assert_not policy.create?, "Regular user should not be allowed to create a scenario"

    policy_system = PredefinedScenarioPolicy.new(@system_user, PredefinedScenario.new)
    assert policy_system.create?, "System user should be allowed to create a scenario"
  end

  def test_update
    policy = PredefinedScenarioPolicy.new(@regular_user, @scenario)
    assert_not policy.update?, "Regular user should not be allowed to update the scenario"

    policy_system = PredefinedScenarioPolicy.new(@system_user, @scenario)
    assert policy_system.update?, "System user should be allowed to update the scenario"
  end

  def test_destroy
    policy = PredefinedScenarioPolicy.new(@regular_user, @scenario)
    assert_not policy.destroy?, "Regular user should not be allowed to destroy the scenario"

    policy_system = PredefinedScenarioPolicy.new(@system_user, @scenario)
    assert policy_system.destroy?, "System user should be allowed to destroy the scenario"
  end
end
