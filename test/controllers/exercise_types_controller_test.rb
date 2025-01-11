require "test_helper"

class ExerciseTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_type = Fabricate(:exercise_type)
    @user = Fabricate(:user_with_team)
    sign_in @user
  end

  test "should get index" do
    get exercise_types_url
    assert_response :success
  end

  test "should show exercise_type" do
    get exercise_type_url(@exercise_type)
    assert_response :success
  end
end
