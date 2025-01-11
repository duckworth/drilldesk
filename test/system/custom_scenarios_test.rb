require "application_system_test_case"

class CustomScenariosTest < ApplicationSystemTestCase
  setup do
    @custom_scenario = Fabricate(:custom_scenario)
  end

  test "visiting the index" do
    visit custom_scenarios_url
    assert_selector "h1", text: "Custom scenarios"
  end

  test "should create custom scenario" do
    visit custom_scenarios_url
    click_on "New custom scenario"

    fill_in "Created by", with: @custom_scenario.created_by_id
    fill_in "Description", with: @custom_scenario.description
    fill_in "Exercise type", with: @custom_scenario.exercise_type_id
    fill_in "Name", with: @custom_scenario.name
    fill_in "Source text", with: @custom_scenario.source_text
    fill_in "Team", with: @custom_scenario.team_id
    click_on "Create Custom scenario"

    assert_text "Custom scenario was successfully created"
    click_on "Back"
  end

  test "should update Custom scenario" do
    visit custom_scenario_url(@custom_scenario)
    click_on "Edit this custom scenario", match: :first

    fill_in "Created by", with: @custom_scenario.created_by_id
    fill_in "Description", with: @custom_scenario.description
    fill_in "Exercise type", with: @custom_scenario.exercise_type_id
    fill_in "Name", with: @custom_scenario.name
    fill_in "Source text", with: @custom_scenario.source_text
    fill_in "Team", with: @custom_scenario.team_id
    click_on "Update Custom scenario"

    assert_text "Custom scenario was successfully updated"
    click_on "Back"
  end

  test "should destroy Custom scenario" do
    visit custom_scenario_url(@custom_scenario)
    click_on "Destroy this custom scenario", match: :first

    assert_text "Custom scenario was successfully destroyed"
  end
end
