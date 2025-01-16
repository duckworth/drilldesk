require "application_system_test_case"

class PredefinedEventTransitionsTest < ApplicationSystemTestCase
  setup do
    @predefined_event_transition = Fabricate(:predefined_event_transition)
  end

  test "visiting the index" do
    visit predefined_event_transitions_url
    assert_selector "h1", text: "Predefined event transitions"
  end

  test "should create predefined event transition" do
    visit predefined_event_transitions_url
    click_on "New predefined event transition"

    fill_in "Condition", with: @predefined_event_transition.condition
    fill_in "From event", with: @predefined_event_transition.from_event_id
    fill_in "To event", with: @predefined_event_transition.to_event_id
    click_on "Create Predefined event transition"

    assert_text "Predefined event transition was successfully created"
    click_on "Back"
  end

  test "should update Predefined event transition" do
    visit predefined_event_transition_url(@predefined_event_transition)
    click_on "Edit this predefined event transition", match: :first

    fill_in "Condition", with: @predefined_event_transition.condition
    fill_in "From event", with: @predefined_event_transition.from_event_id
    fill_in "To event", with: @predefined_event_transition.to_event_id
    click_on "Update Predefined event transition"

    assert_text "Predefined event transition was successfully updated"
    click_on "Back"
  end

  test "should destroy Predefined event transition" do
    visit predefined_event_transition_url(@predefined_event_transition)
    click_on "Destroy this predefined event transition", match: :first

    assert_text "Predefined event transition was successfully destroyed"
  end
end
