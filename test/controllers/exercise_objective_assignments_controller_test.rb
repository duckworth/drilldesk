require "test_helper"

class ExerciseObjectiveAssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user, @team = user_with_team
    sign_in @user
    @exercise_objective_assignment = Fabricate(:exercise_objective_assignment)
  end

  test "should get index" do
    get exercise_objective_assignments_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_objective_assignment_url
    assert_response :success
  end

  test "should create exercise_objective_assignment" do
    assert_difference("ExerciseObjectiveAssignment.count") do
      post exercise_objective_assignments_url, params: { exercise_objective_assignment: { exercise_id: @exercise_objective_assignment.exercise_id, exercise_objective_id: @exercise_objective_assignment.exercise_objective_id, priority: @exercise_objective_assignment.priority, team_id: @exercise_objective_assignment.team_id } }
    end

    assert_redirected_to exercise_objective_assignment_url(ExerciseObjectiveAssignment.order(id: :desc).first)
  end

  test "should show exercise_objective_assignment" do
    get exercise_objective_assignment_url(@exercise_objective_assignment)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_objective_assignment_url(@exercise_objective_assignment)
    assert_response :success
  end

  test "should update exercise_objective_assignment" do
    patch exercise_objective_assignment_url(@exercise_objective_assignment), params: { exercise_objective_assignment: { exercise_id: @exercise_objective_assignment.exercise_id, exercise_objective_id: @exercise_objective_assignment.exercise_objective_id, priority: @exercise_objective_assignment.priority, team_id: @exercise_objective_assignment.team_id } }
    assert_redirected_to exercise_objective_assignment_url(@exercise_objective_assignment)
  end

  test "should destroy exercise_objective_assignment" do
    assert_difference("ExerciseObjectiveAssignment.count", -1) do
      delete exercise_objective_assignment_url(@exercise_objective_assignment)
    end

    assert_redirected_to exercise_objective_assignments_url
  end
end
