require "application_system_test_case"

class PredefinedEventsTest < ApplicationSystemTestCase
  setup do
    @predefined_event = Fabricate(:predefined_event)
  end

  test "visiting the index" do
    visit predefined_events_url
    assert_selector "h1", text: "Predefined events"
  end

  test "should create predefined event" do
    visit predefined_events_url
    click_on "New predefined event"

    fill_in "Description", with: @predefined_event.description
    fill_in "Name", with: @predefined_event.name
    fill_in "Predefined scenario", with: @predefined_event.predefined_scenario_id
    click_on "Create Predefined event"

    assert_text "Predefined event was successfully created"
    click_on "Back"
  end

  test "should update Predefined event" do
    visit predefined_event_url(@predefined_event)
    click_on "Edit this predefined event", match: :first

    fill_in "Description", with: @predefined_event.description
    fill_in "Name", with: @predefined_event.name
    fill_in "Predefined scenario", with: @predefined_event.predefined_scenario_id
    click_on "Update Predefined event"

    assert_text "Predefined event was successfully updated"
    click_on "Back"
  end

  test "should destroy Predefined event" do
    visit predefined_event_url(@predefined_event)
    click_on "Destroy this predefined event", match: :first

    assert_text "Predefined event was successfully destroyed"
  end
end
