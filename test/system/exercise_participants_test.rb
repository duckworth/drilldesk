require "application_system_test_case"

class ExerciseParticipantsTest < ApplicationSystemTestCase
  setup do
    @exercise_participant = Fabricate(:exercise_participant)
  end

  test "visiting the index" do
    visit exercise_participants_url
    assert_selector "h1", text: "Exercise participants"
  end

  test "should create exercise participant" do
    visit exercise_participants_url
    click_on "New exercise participant"

    fill_in "Exercise", with: @exercise_participant.exercise_id
    fill_in "Name", with: @exercise_participant.name
    fill_in "Role", with: @exercise_participant.role
    fill_in "Team", with: @exercise_participant.team_id
    fill_in "User", with: @exercise_participant.user_id
    click_on "Create Exercise participant"

    assert_text "Exercise participant was successfully created"
    click_on "Back"
  end

  test "should update Exercise participant" do
    visit exercise_participant_url(@exercise_participant)
    click_on "Edit this exercise participant", match: :first

    fill_in "Exercise", with: @exercise_participant.exercise_id
    fill_in "Name", with: @exercise_participant.name
    fill_in "Role", with: @exercise_participant.role
    fill_in "Team", with: @exercise_participant.team_id
    fill_in "User", with: @exercise_participant.user_id
    click_on "Update Exercise participant"

    assert_text "Exercise participant was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise participant" do
    visit exercise_participant_url(@exercise_participant)
    click_on "Destroy this exercise participant", match: :first

    assert_text "Exercise participant was successfully destroyed"
  end
end
