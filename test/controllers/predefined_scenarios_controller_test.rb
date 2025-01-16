require "test_helper"

class PredefinedScenariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @predefined_scenario = Fabricate(:predefined_scenario)
  end

  test "should get index" do
    get predefined_scenarios_url
    assert_response :success
  end

  test "should get new" do
    get new_predefined_scenario_url
    assert_response :success
  end

  test "should create predefined_scenario" do
    assert_difference("PredefinedScenario.count") do
      post predefined_scenarios_url, params: { predefined_scenario: { description: @predefined_scenario.description, exercise_type_id: @predefined_scenario.exercise_type_id, name: @predefined_scenario.name, starting_scenario_event_id: @predefined_scenario.starting_scenario_event_id } }
    end

    assert_redirected_to predefined_scenario_url(PredefinedScenario.last)
  end

  test "should show predefined_scenario" do
    get predefined_scenario_url(@predefined_scenario)
    assert_response :success
  end

  test "should get edit" do
    get edit_predefined_scenario_url(@predefined_scenario)
    assert_response :success
  end

  test "should update predefined_scenario" do
    patch predefined_scenario_url(@predefined_scenario), params: { predefined_scenario: { description: @predefined_scenario.description, exercise_type_id: @predefined_scenario.exercise_type_id, name: @predefined_scenario.name, starting_scenario_event_id: @predefined_scenario.starting_scenario_event_id } }
    assert_redirected_to predefined_scenario_url(@predefined_scenario)
  end

  test "should destroy predefined_scenario" do
    assert_difference("PredefinedScenario.count", -1) do
      delete predefined_scenario_url(@predefined_scenario)
    end

    assert_redirected_to predefined_scenarios_url
  end
end
