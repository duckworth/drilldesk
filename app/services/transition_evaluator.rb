# app/services/transition_evaluator.rb
class TransitionEvaluator < ActiveInteraction::Base
  object :transition, class: PredefinedEventTransition
  object :context, class: Hash, default: {}  # Explicitly specify Hash

  # e.g., context includes scenario start time, flags, events_triggered_at, etc.

  def execute
    transition_condition = transition.condition
    return false unless transition_condition.is_a?(Hash)

    logic_type = transition_condition["logic"]&.upcase || "AND"
    sub_conditions = transition_condition["conditions"] || []

    results = sub_conditions.map do |cond|
      ConditionEvaluator.run(condition: cond, context: context)
    end

    # Combine results based on logic
    bool_results = results.map(&:result)

    if logic_type == "AND"
      bool_results.all?(true)
    elsif logic_type == "OR"
      bool_results.any?(true)
    else
      # default to AND if unknown
      bool_results.all?(true)
    end
  end
end
