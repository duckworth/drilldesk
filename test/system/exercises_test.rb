require "application_system_test_case"

class ExercisesTest < ApplicationSystemTestCase
  setup do
    @exercise = Fabricate(:exercise)
  end

  test "visiting the index" do
    visit exercises_url
    assert_selector "h1", text: "Exercises"
  end

  test "should create exercise" do
    visit exercises_url
    click_on "New exercise"

    fill_in "Context data", with: @exercise.context_data
    fill_in "Custom scenario", with: @exercise.custom_scenario_id
    fill_in "Exercise date", with: @exercise.exercise_date
    fill_in "Exercise type", with: @exercise.exercise_type_id
    fill_in "Name", with: @exercise.name
    fill_in "Predefined scenario", with: @exercise.predefined_scenario_id
    fill_in "Purpose", with: @exercise.purpose
    fill_in "Status", with: @exercise.status
    fill_in "Team", with: @exercise.team_id
    click_on "Create Exercise"

    assert_text "Exercise was successfully created"
    click_on "Back"
  end

  test "should update Exercise" do
    visit exercise_url(@exercise)
    click_on "Edit this exercise", match: :first

    fill_in "Context data", with: @exercise.context_data
    fill_in "Custom scenario", with: @exercise.custom_scenario_id
    fill_in "Exercise date", with: @exercise.exercise_date.to_s
    fill_in "Exercise type", with: @exercise.exercise_type_id
    fill_in "Name", with: @exercise.name
    fill_in "Predefined scenario", with: @exercise.predefined_scenario_id
    fill_in "Purpose", with: @exercise.purpose
    fill_in "Status", with: @exercise.status
    fill_in "Team", with: @exercise.team_id
    click_on "Update Exercise"

    assert_text "Exercise was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise" do
    visit exercise_url(@exercise)
    click_on "Destroy this exercise", match: :first

    assert_text "Exercise was successfully destroyed"
  end
end
