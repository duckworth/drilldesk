class PredefinedScenario < Scenario
  has_many :predefined_events
  belongs_to :starting_scenario_event, class_name: "PredefinedEvent"
  has_many :exercises, as: :scenario
  scope :enabled, -> { where(enabled: true) }
end
