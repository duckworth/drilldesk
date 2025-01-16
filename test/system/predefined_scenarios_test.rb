require "application_system_test_case"

class PredefinedScenariosTest < ApplicationSystemTestCase
  setup do
    @predefined_scenario = Fabricate(:predefined_scenario)
  end

  test "visiting the index" do
    visit predefined_scenarios_url
    assert_selector "h1", text: "Predefined scenarios"
  end

  test "should create predefined scenario" do
    visit predefined_scenarios_url
    click_on "New predefined scenario"

    fill_in "Description", with: @predefined_scenario.description
    fill_in "Exercise type", with: @predefined_scenario.exercise_type_id
    fill_in "Name", with: @predefined_scenario.name
    fill_in "Starting scenario event", with: @predefined_scenario.starting_scenario_event_id
    click_on "Create Predefined scenario"

    assert_text "Predefined scenario was successfully created"
    click_on "Back"
  end

  test "should update Predefined scenario" do
    visit predefined_scenario_url(@predefined_scenario)
    click_on "Edit this predefined scenario", match: :first

    fill_in "Description", with: @predefined_scenario.description
    fill_in "Exercise type", with: @predefined_scenario.exercise_type_id
    fill_in "Name", with: @predefined_scenario.name
    fill_in "Starting scenario event", with: @predefined_scenario.starting_scenario_event_id
    click_on "Update Predefined scenario"

    assert_text "Predefined scenario was successfully updated"
    click_on "Back"
  end

  test "should destroy Predefined scenario" do
    visit predefined_scenario_url(@predefined_scenario)
    click_on "Destroy this predefined scenario", match: :first

    assert_text "Predefined scenario was successfully destroyed"
  end
end
