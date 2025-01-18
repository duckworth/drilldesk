class PredefinedEvent < Event
  belongs_to :predefined_scenario

  scope :enabled, -> { where(enabled: true) }
end
