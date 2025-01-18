require "application_system_test_case"

class ExerciseEventsTest < ApplicationSystemTestCase
  setup do
    @exercise_event = Fabricate(:exercise_event)
  end

  test "visiting the index" do
    visit exercise_events_url
    assert_selector "h1", text: "Exercise events"
  end

  test "should create exercise event" do
    visit exercise_events_url
    click_on "New exercise event"

    fill_in "Custom event", with: @exercise_event.custom_event_id
    fill_in "Exercise", with: @exercise_event.exercise_id
    fill_in "Predefined event", with: @exercise_event.predefined_event_id
    fill_in "Relative event time", with: @exercise_event.relative_event_time
    fill_in "Status", with: @exercise_event.status
    fill_in "Team", with: @exercise_event.team_id
    fill_in "Triggered at", with: @exercise_event.triggered_at
    click_on "Create Exercise event"

    assert_text "Exercise event was successfully created"
    click_on "Back"
  end

  test "should update Exercise event" do
    visit exercise_event_url(@exercise_event)
    click_on "Edit this exercise event", match: :first

    fill_in "Custom event", with: @exercise_event.custom_event_id
    fill_in "Exercise", with: @exercise_event.exercise_id
    fill_in "Predefined event", with: @exercise_event.predefined_event_id
    fill_in "Relative event time", with: @exercise_event.relative_event_time
    fill_in "Status", with: @exercise_event.status
    fill_in "Team", with: @exercise_event.team_id
    fill_in "Triggered at", with: @exercise_event.triggered_at.to_s
    click_on "Update Exercise event"

    assert_text "Exercise event was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise event" do
    visit exercise_event_url(@exercise_event)
    click_on "Destroy this exercise event", match: :first

    assert_text "Exercise event was successfully destroyed"
  end
end
