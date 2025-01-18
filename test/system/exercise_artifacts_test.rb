require "application_system_test_case"

class ExerciseArtifactsTest < ApplicationSystemTestCase
  setup do
    @exercise_artifact = Fabricate(:exercise_artifact)
  end

  test "visiting the index" do
    visit exercise_artifacts_url
    assert_selector "h1", text: "Exercise artifacts"
  end

  test "should create exercise artifact" do
    visit exercise_artifacts_url
    click_on "New exercise artifact"

    fill_in "Artifact type", with: @exercise_artifact.artifact_type
    fill_in "Exercise", with: @exercise_artifact.exercise_id
    fill_in "Team", with: @exercise_artifact.team_id
    click_on "Create Exercise artifact"

    assert_text "Exercise artifact was successfully created"
    click_on "Back"
  end

  test "should update Exercise artifact" do
    visit exercise_artifact_url(@exercise_artifact)
    click_on "Edit this exercise artifact", match: :first

    fill_in "Artifact type", with: @exercise_artifact.artifact_type
    fill_in "Exercise", with: @exercise_artifact.exercise_id
    fill_in "Team", with: @exercise_artifact.team_id
    click_on "Update Exercise artifact"

    assert_text "Exercise artifact was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise artifact" do
    visit exercise_artifact_url(@exercise_artifact)
    click_on "Destroy this exercise artifact", match: :first

    assert_text "Exercise artifact was successfully destroyed"
  end
end
