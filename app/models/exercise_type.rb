class ExerciseType < ApplicationRecord
  scope :enabled, -> { where(enabled: true) }
end
