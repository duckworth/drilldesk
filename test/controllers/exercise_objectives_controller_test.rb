require "test_helper"

class ExerciseObjectivesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_objective = Fabricate(:exercise_objective)
    @user = Fabricate(:user_with_team)
    sign_in @user
  end

  test "should get index" do
    get exercise_objectives_url
    assert_response :success
  end

  test "should show exercise_objective" do
    get exercise_objective_url(@exercise_objective)
    assert_response :success
  end
end
