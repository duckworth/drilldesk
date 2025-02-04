class ExerciseEvent < ApplicationRecord
  include ExerciseEvent::States
  belongs_to :team
  belongs_to :exercise
  belongs_to :event, polymorphic: true

  acts_as_tenant(:team)
  has_paper_trail
  default_scope { order(id: :desc) }


  validates :event, presence: true
  validate :event_type_matches_scenario_type
  validate :event_immutable, on: :update

  private

  def event_type_matches_scenario_type
    return unless event && exercise

    errors.add(:event, "incorrect Event type") if (exercise.scenario_type == "CustomScenario" && event_type != "CustomEvent") ||
      (exercise.scenario_type == "PredefinedScenario" && event_type != "PredefinedEvent")
  end
  def event_immutable
    if event_id_changed? || event_type_changed?
      errors.add(:event, "cannot be changed once the exercise event is created")
    end
  end
end
