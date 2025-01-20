require "test_helper"

class ExerciseTest < ActiveSupport::TestCase
  setup do
    with_team
  end

  test "custom_exercise should be valid" do
    @exercise = Fabricate(:custom_exercise)
    assert @exercise.valid?
  end

  test "predefined_exercise should be valid" do
    @exercise = Fabricate(:predefined_exercise)
    assert @exercise.valid?
  end
end
