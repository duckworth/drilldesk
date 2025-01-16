class PredefinedScenario < ApplicationRecord
  belongs_to :exercise_type
  belongs_to :starting_scenario_event, class_name: "PredefinedEvent"
  scope :enabled, -> { where(enabled: true) }
end
