require "application_system_test_case"

class InteractionsTest < ApplicationSystemTestCase
  setup do
    @interaction = Fabricate(:interaction)
  end

  test "visiting the index" do
    visit interactions_url
    assert_selector "h1", text: "Interactions"
  end

  test "should create interaction" do
    visit interactions_url
    click_on "New interaction"

    fill_in "Ai response", with: @interaction.ai_response
    fill_in "Exercise event", with: @interaction.exercise_event_id
    fill_in "Exercise", with: @interaction.exercise_id
    fill_in "Interaction type", with: @interaction.interaction_type
    fill_in "Response confidence", with: @interaction.response_confidence
    fill_in "Team", with: @interaction.team_id
    fill_in "User", with: @interaction.user_id
    fill_in "User input", with: @interaction.user_input
    click_on "Create Interaction"

    assert_text "Interaction was successfully created"
    click_on "Back"
  end

  test "should update Interaction" do
    visit interaction_url(@interaction)
    click_on "Edit this interaction", match: :first

    fill_in "Ai response", with: @interaction.ai_response
    fill_in "Exercise event", with: @interaction.exercise_event_id
    fill_in "Exercise", with: @interaction.exercise_id
    fill_in "Interaction type", with: @interaction.interaction_type
    fill_in "Response confidence", with: @interaction.response_confidence
    fill_in "Team", with: @interaction.team_id
    fill_in "User", with: @interaction.user_id
    fill_in "User input", with: @interaction.user_input
    click_on "Update Interaction"

    assert_text "Interaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Interaction" do
    visit interaction_url(@interaction)
    click_on "Destroy this interaction", match: :first

    assert_text "Interaction was successfully destroyed"
  end
end
