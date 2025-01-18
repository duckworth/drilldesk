class Scenario < ApplicationRecord
  self.abstract_class = true
  belongs_to :exercise_type
end
