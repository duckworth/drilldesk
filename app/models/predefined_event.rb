class PredefinedEvent < ApplicationRecord
  belongs_to :predefined_scenario

  scope :enabled, -> { where(enabled: true) }
end
