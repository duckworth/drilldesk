require "test_helper"

class CustomScenariosControllerTest < TeamIntegrationTest
  setup do
    @user, @team = user_with_team
    sign_in @user
    @custom_scenario = Fabricate(:custom_scenario, team: @team, created_by: @user)
  end

  test "should get index" do
    get custom_scenarios_url(@team)
    assert_response :success
  end

  test "should get new" do
    get new_custom_scenario_url(@team)
    assert_response :success
  end

  test "should create custom_scenario" do
    assert_difference("CustomScenario.count") do
      post custom_scenarios_url(@team), params: { custom_scenario: { description: @custom_scenario.description, exercise_type_id: @custom_scenario.exercise_type_id, name: @custom_scenario.name, source_text: @custom_scenario.source_text } }
    end

    assert_redirected_to custom_scenario_url(CustomScenario.first)
  end

  test "should show custom_scenario" do
    get custom_scenario_url(@team, @custom_scenario)
    assert_response :success
  end

  test "should get edit" do
    get edit_custom_scenario_url(@team, @custom_scenario)
    assert_response :success
  end

  test "should update custom_scenario" do
    patch custom_scenario_url(@team, @custom_scenario), params: { custom_scenario: { created_by_id: @custom_scenario.created_by_id, description: @custom_scenario.description, exercise_type_id: @custom_scenario.exercise_type_id, name: @custom_scenario.name, source_text: @custom_scenario.source_text, team_id: @custom_scenario.team_id } }
    assert_redirected_to custom_scenario_url(@team, @custom_scenario)
  end

  test "should destroy custom_scenario" do
    assert_difference("CustomScenario.count", -1) do
      delete custom_scenario_url(@team, @custom_scenario)
    end

    assert_redirected_to custom_scenarios_url
  end
end
