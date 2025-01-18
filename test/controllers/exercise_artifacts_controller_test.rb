require "test_helper"

class ExerciseArtifactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_artifact = Fabricate(:exercise_artifact)
  end

  test "should get index" do
    get exercise_artifacts_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_artifact_url
    assert_response :success
  end

  test "should create exercise_artifact" do
    assert_difference("ExerciseArtifact.count") do
      post exercise_artifacts_url, params: { exercise_artifact: { artifact_type: @exercise_artifact.artifact_type, exercise_id: @exercise_artifact.exercise_id, team_id: @exercise_artifact.team_id } }
    end

    assert_redirected_to exercise_artifact_url(ExerciseArtifact.last)
  end

  test "should show exercise_artifact" do
    get exercise_artifact_url(@exercise_artifact)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_artifact_url(@exercise_artifact)
    assert_response :success
  end

  test "should update exercise_artifact" do
    patch exercise_artifact_url(@exercise_artifact), params: { exercise_artifact: { artifact_type: @exercise_artifact.artifact_type, exercise_id: @exercise_artifact.exercise_id, team_id: @exercise_artifact.team_id } }
    assert_redirected_to exercise_artifact_url(@exercise_artifact)
  end

  test "should destroy exercise_artifact" do
    assert_difference("ExerciseArtifact.count", -1) do
      delete exercise_artifact_url(@exercise_artifact)
    end

    assert_redirected_to exercise_artifacts_url
  end
end
