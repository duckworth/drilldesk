require "application_system_test_case"

class CustomEventsTest < ApplicationSystemTestCase
  setup do
    @custom_event = Fabricate(:custom_event)
  end

  test "visiting the index" do
    visit custom_events_url
    assert_selector "h1", text: "Custom events"
  end

  test "should create custom event" do
    visit custom_events_url
    click_on "New custom event"

    fill_in "Custom scenario", with: @custom_event.custom_scenario_id
    fill_in "Description", with: @custom_event.description
    fill_in "Name", with: @custom_event.name
    fill_in "Sequence order", with: @custom_event.sequence_order
    fill_in "Team", with: @custom_event.team_id
    fill_in "Trigger keywords", with: @custom_event.trigger_keywords
    click_on "Create Custom event"

    assert_text "Custom event was successfully created"
    click_on "Back"
  end

  test "should update Custom event" do
    visit custom_event_url(@custom_event)
    click_on "Edit this custom event", match: :first

    fill_in "Custom scenario", with: @custom_event.custom_scenario_id
    fill_in "Description", with: @custom_event.description
    fill_in "Name", with: @custom_event.name
    fill_in "Sequence order", with: @custom_event.sequence_order
    fill_in "Team", with: @custom_event.team_id
    fill_in "Trigger keywords", with: @custom_event.trigger_keywords
    click_on "Update Custom event"

    assert_text "Custom event was successfully updated"
    click_on "Back"
  end

  test "should destroy Custom event" do
    visit custom_event_url(@custom_event)
    click_on "Destroy this custom event", match: :first

    assert_text "Custom event was successfully destroyed"
  end
end
