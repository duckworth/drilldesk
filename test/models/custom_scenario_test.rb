require "test_helper"

class CustomScenarioTest < ActiveSupport::TestCase
  setup do
    with_team
  end

  test "CustomScenario id order chronologically" do
    Fabricate.times(10, :custom_scenario)

    custom_scenarios = CustomScenario.all
    assert_equal custom_scenarios.pluck(:id), custom_scenarios.order(created_at: :desc).pluck(:id)
    assert_equal custom_scenarios.pluck(:created_at), custom_scenarios.pluck(:created_at).sort.reverse
  end
end
