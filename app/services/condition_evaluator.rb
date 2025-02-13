class ConditionEvaluator < ActiveInteraction::Base
  # We pass in a single condition Hash
  hash :condition do
    string :type
    # We allow optional keys. 'value' is typically a string, integer, or boolean
    # depending on the condition type. We'll parse them dynamically.
    object :value, class: Object, default: nil
    string :description, default: nil
  end

  # Some context so we know times, flags, etc.
  object :context, class: Hash, default: {}

  # e.g., context might contain:
  #   context[:scenario_started_at] => Time
  #   context[:events_triggered_at] => { event_id => Time }
  #   context[:flags] => { "containment_failed" => true, ...}
  #   context[:decisions] => { "activate_bc_dr_plan" => true, ...}
  #   context[:alerts_count] => 5
  #   context[:now] => Time.current

  def execute
    case condition[:type]
    when "manual_override"
      evaluate_manual_override
    when "time_elapsed"
      evaluate_time_elapsed
    when "time_elapsed_after_event"
      evaluate_time_elapsed_after_event
    when "alert_threshold"
      evaluate_alert_threshold
    when "flag_set"
      evaluate_flag_set
    when "decision_made"
      evaluate_decision_made
    else
      errors.add(:base, "Unknown condition type: #{condition[:type]}")
      false
    end
  end

  private

  # ============== Condition Type Handlers ===============

  def evaluate_manual_override
    # Instead of always returning true when condition[:value] is true,
    # we check the context for an override flag.
    context[:override] == true
  end


  def evaluate_time_elapsed
    # condition[:value] might be "PT15M" (ISO8601 duration).
    required_duration = parse_iso8601_duration(condition[:value])
    scenario_start    = context[:scenario_started_at] || Time.current
    now              = context[:now] || Time.current
    (now - scenario_start) >= required_duration
  end

  def evaluate_time_elapsed_after_event
    # condition[:value] might be "PT20M"
    # we might also need condition[:event_id] or something.
    required_duration = parse_iso8601_duration(condition[:value])
    reference_event_id = condition[:event_id] # or name if you store name

    triggered_at = context.dig(:events_triggered_at, reference_event_id)
    return false unless triggered_at.present?

    now = context[:now] || Time.current
    (now - triggered_at) >= required_duration
  end

  def evaluate_alert_threshold
    # condition[:value] might be an integer, e.g. 3
    # or a boolean if you do a yes/no threshold reached
    threshold = condition[:value].to_i
    current_alerts = context[:alerts_count].to_i
    current_alerts >= threshold
  end

  def evaluate_flag_set
    # condition[:value] might be "containment_failed"
    # We check context[:flags][flag_name]
    flag_name = condition[:value].to_s
    context.dig(:flags, flag_name) == true
  end

  def evaluate_decision_made
    # condition[:value] might be "activate_bc_dr_plan"
    # We check context[:decisions][decision_label]
    decision_label = condition[:value].to_s
    context.dig(:decisions, decision_label) == true
  end

  # ============= Helper Methods =============
  def parse_iso8601_duration(value)
    # If you always store durations as strings like "PT15M", we can parse them.
    # Alternatively, if it's just minutes as an integer, handle it differently.
    ActiveSupport::Duration.parse(value) # if using Rails' activesupport
  rescue StandardError
    0
  end
end
