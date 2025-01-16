class ExerciseObjectiveAssignment < ApplicationRecord
  belongs_to :team
  belongs_to :exercise
  belongs_to :exercise_objective
  acts_as_tenant(:team)
  default_scope { order(priority: :asc) }
end
