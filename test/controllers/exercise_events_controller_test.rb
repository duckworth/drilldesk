require "test_helper"

class ExerciseEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user, @team = user_with_team
    sign_in @user
    @exercise_event = Fabricate(:predefined_exercise_event, team: @team)
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
      post exercise_events_url, params: { exercise_event: { exercise_id: @exercise_event.exercise_id, predefined_event_id: @exercise_event.event_id, relative_event_time: @exercise_event.relative_event_time, triggered_at: @exercise_event.triggered_at } }
      assert_not_equal 422, response.status, "Expected response not to be 422. Model errors: #{@controller.view_assigns['exercise_event'].errors.full_messages.join(', ')}"
    end

    assert_redirected_to exercise_event_url(ExerciseEvent.first)
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
    @exercise_event
    patch exercise_event_url(@exercise_event), params: { exercise_event: { exercise_id: @exercise_event.exercise_id, relative_event_time: @exercise_event.relative_event_time, triggered_at: @exercise_event.triggered_at } }
    assert_redirected_to exercise_event_url(@exercise_event)
  end

  test "should destroy exercise_event" do
    assert_difference("ExerciseEvent.count", -1) do
      delete exercise_event_url(@exercise_event)
    end

    assert_redirected_to exercise_events_url
  end
end
