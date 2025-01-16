require "application_system_test_case"

class ExerciseObjectiveAssignmentsTest < ApplicationSystemTestCase
  setup do
    @exercise_objective_assignment = Fabricate(:exercise_objective_assignment)
  end

  test "visiting the index" do
    visit exercise_objective_assignments_url
    assert_selector "h1", text: "Exercise objective assignments"
  end

  test "should create exercise objective assignment" do
    visit exercise_objective_assignments_url
    click_on "New exercise objective assignment"

    fill_in "Exercise", with: @exercise_objective_assignment.exercise_id
    fill_in "Exercise objective", with: @exercise_objective_assignment.exercise_objective_id
    fill_in "Priority", with: @exercise_objective_assignment.priority
    fill_in "Team", with: @exercise_objective_assignment.team_id
    click_on "Create Exercise objective assignment"

    assert_text "Exercise objective assignment was successfully created"
    click_on "Back"
  end

  test "should update Exercise objective assignment" do
    visit exercise_objective_assignment_url(@exercise_objective_assignment)
    click_on "Edit this exercise objective assignment", match: :first

    fill_in "Exercise", with: @exercise_objective_assignment.exercise_id
    fill_in "Exercise objective", with: @exercise_objective_assignment.exercise_objective_id
    fill_in "Priority", with: @exercise_objective_assignment.priority
    fill_in "Team", with: @exercise_objective_assignment.team_id
    click_on "Update Exercise objective assignment"

    assert_text "Exercise objective assignment was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise objective assignment" do
    visit exercise_objective_assignment_url(@exercise_objective_assignment)
    click_on "Destroy this exercise objective assignment", match: :first

    assert_text "Exercise objective assignment was successfully destroyed"
  end
end
