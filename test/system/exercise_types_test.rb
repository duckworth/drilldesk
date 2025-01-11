require "application_system_test_case"

class ExerciseTypesTest < ApplicationSystemTestCase
  setup do
    @exercise_type = Fabricate(:exercise_type)
  end

  test "visiting the index" do
    visit exercise_types_url
    assert_selector "h1", text: "Exercise types"
  end
end
