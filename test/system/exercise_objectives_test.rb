require "application_system_test_case"

class ExerciseObjectivesTest < ApplicationSystemTestCase
  setup do
    @exercise_objective = Fabricate(:exercise_objective)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "visiting the index" do
    visit exercise_objectives_url
    assert_selector "h1", text: "Exercise objectives"
  end
end
