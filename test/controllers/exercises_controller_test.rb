require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user, @team = user_with_team
    sign_in @user
    @exercise = Fabricate(:predefined_exercise, team: @team)
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
    predefined_scenario_id = Fabricate(:predefined_scenario).id
    assert_difference("Exercise.count") do
      post exercises_url, params: { exercise: { context_data: @exercise.context_data, predefined_scenario_id: predefined_scenario_id, exercise_date: @exercise.exercise_date, exercise_type_id: @exercise.exercise_type_id, name: @exercise.name,  purpose: @exercise.purpose, status: @exercise.status } }
    end

    assert_redirected_to exercise_url(Exercise.first)
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
    patch exercise_url(@exercise), params: { exercise: { context_data: @exercise.context_data, exercise_date: @exercise.exercise_date, exercise_type_id: @exercise.exercise_type_id, name: @exercise.name, purpose: @exercise.purpose } }
    assert_redirected_to exercise_url(@exercise)
  end

  test "should destroy exercise" do
    assert_difference("Exercise.count", -1) do
      delete exercise_url(@exercise)
    end

    assert_redirected_to exercises_url
  end
end
