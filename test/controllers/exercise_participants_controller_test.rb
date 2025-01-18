require "test_helper"

class ExerciseParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_participant = Fabricate(:exercise_participant)
  end

  test "should get index" do
    get exercise_participants_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_participant_url
    assert_response :success
  end

  test "should create exercise_participant" do
    assert_difference("ExerciseParticipant.count") do
      post exercise_participants_url, params: { exercise_participant: { exercise_id: @exercise_participant.exercise_id, name: @exercise_participant.name, role: @exercise_participant.role, team_id: @exercise_participant.team_id, user_id: @exercise_participant.user_id } }
    end

    assert_redirected_to exercise_participant_url(ExerciseParticipant.last)
  end

  test "should show exercise_participant" do
    get exercise_participant_url(@exercise_participant)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_participant_url(@exercise_participant)
    assert_response :success
  end

  test "should update exercise_participant" do
    patch exercise_participant_url(@exercise_participant), params: { exercise_participant: { exercise_id: @exercise_participant.exercise_id, name: @exercise_participant.name, role: @exercise_participant.role, team_id: @exercise_participant.team_id, user_id: @exercise_participant.user_id } }
    assert_redirected_to exercise_participant_url(@exercise_participant)
  end

  test "should destroy exercise_participant" do
    assert_difference("ExerciseParticipant.count", -1) do
      delete exercise_participant_url(@exercise_participant)
    end

    assert_redirected_to exercise_participants_url
  end
end
