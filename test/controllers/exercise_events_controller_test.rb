require "test_helper"

class ExerciseEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_event = Fabricate(:exercise_event)
  end

  test "should get index" do
    get exercise_events_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_event_url
    assert_response :success
  end

  test "should create exercise_event" do
    assert_difference("ExerciseEvent.count") do
      post exercise_events_url, params: { exercise_event: { custom_event_id: @exercise_event.custom_event_id, exercise_id: @exercise_event.exercise_id, predefined_event_id: @exercise_event.predefined_event_id, relative_event_time: @exercise_event.relative_event_time, status: @exercise_event.status, team_id: @exercise_event.team_id, triggered_at: @exercise_event.triggered_at } }
    end

    assert_redirected_to exercise_event_url(ExerciseEvent.last)
  end

  test "should show exercise_event" do
    get exercise_event_url(@exercise_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_event_url(@exercise_event)
    assert_response :success
  end

  test "should update exercise_event" do
    patch exercise_event_url(@exercise_event), params: { exercise_event: { custom_event_id: @exercise_event.custom_event_id, exercise_id: @exercise_event.exercise_id, predefined_event_id: @exercise_event.predefined_event_id, relative_event_time: @exercise_event.relative_event_time, status: @exercise_event.status, team_id: @exercise_event.team_id, triggered_at: @exercise_event.triggered_at } }
    assert_redirected_to exercise_event_url(@exercise_event)
  end

  test "should destroy exercise_event" do
    assert_difference("ExerciseEvent.count", -1) do
      delete exercise_event_url(@exercise_event)
    end

    assert_redirected_to exercise_events_url
  end
end
