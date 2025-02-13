class PredefinedScenario < Scenario
  has_many :predefined_events, dependent: :destroy
  belongs_to :starting_scenario_event, class_name: "PredefinedEvent", optional: true
  has_many :exercises, as: :scenario
  scope :enabled, -> { where(enabled: true) }


  def check_transitions_for_event(event, context)
    transitions = PredefinedEventTransition.where(from_event_id: event.id)
    transitions.each do |trans|
      result = TransitionEvaluator.run(transition: trans, context: context)
      if result.valid? && result.result == true
        # Means we should transition to trans.to_event
        return trans.to_event
      end
    end

    nil # no transition matched
  end
end
