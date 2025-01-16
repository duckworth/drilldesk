require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise = Fabricate(:exercise)
  end

  test "should get index" do
    get exercises_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_url
    assert_response :success
  end

  test "should create exercise" do
    assert_difference("Exercise.count") do
      post exercises_url, params: { exercise: { context_data: @exercise.context_data, custom_scenario_id: @exercise.custom_scenario_id, exercise_date: @exercise.exercise_date, exercise_type_id: @exercise.exercise_type_id, name: @exercise.name, predefined_scenario_id: @exercise.predefined_scenario_id, purpose: @exercise.purpose, status: @exercise.status, team_id: @exercise.team_id } }
    end

    assert_redirected_to exercise_url(Exercise.last)
  end

  test "should show exercise" do
    get exercise_url(@exercise)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_url(@exercise)
    assert_response :success
  end

  test "should update exercise" do
    patch exercise_url(@exercise), params: { exercise: { context_data: @exercise.context_data, custom_scenario_id: @exercise.custom_scenario_id, exercise_date: @exercise.exercise_date, exercise_type_id: @exercise.exercise_type_id, name: @exercise.name, predefined_scenario_id: @exercise.predefined_scenario_id, purpose: @exercise.purpose, status: @exercise.status, team_id: @exercise.team_id } }
    assert_redirected_to exercise_url(@exercise)
  end

  test "should destroy exercise" do
    assert_difference("Exercise.count", -1) do
      delete exercise_url(@exercise)
    end

    assert_redirected_to exercises_url
  end
end
