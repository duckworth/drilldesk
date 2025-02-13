# test/models/predefined_scenario_test.rb

require "test_helper"

class PredefinedScenarioTest < ActiveSupport::TestCase
  setup do
    @scenario = Fabricate(:predefined_scenario_apt_intrusion)

    # Grab references to the events by name
    @event1 = @scenario.predefined_events.find_by(name: "Initial Compromise")
    @event2 = @scenario.predefined_events.find_by(name: "Lateral Movement")
    @event3 = @scenario.predefined_events.find_by(name: "Detection & Triage")
    @event4 = @scenario.predefined_events.find_by(name: "Containment & Investigation")
    @event5 = @scenario.predefined_events.find_by(name: "Data Exfiltration / Attack Escalation (Branch)")
    @event6 = @scenario.predefined_events.find_by(name: "Eradication, Recovery & Post-Incident")

    # Sanity checks
    assert @event1, "Event1: Initial Compromise must exist"
    assert @event2, "Event2: Lateral Movement must exist"
    assert @event3, "Event3: Detection & Triage must exist"
    assert @event4, "Event4: Containment & Investigation must exist"
    assert @event5, "Event5: Data Exfiltration / Attack Escalation must exist"
    assert @event6, "Event6: Eradication, Recovery & Post-Incident must exist"
  end

  test "event1 -> event2 triggers on time_elapsed" do
    # Satisfy time_elapsed (10 minutes have passed since scenario start)
    context = {
      scenario_started_at: 10.minutes.ago,
      now: Time.current
    }

    next_event = @scenario.check_transitions_for_event(@event1, context)
    assert_equal @event2, next_event, "Should transition to Lateral Movement after 10 minutes"
  end

  test "event1 -> event2 triggers on manual_override" do
    # Provide manual override via context
    context = {
      scenario_started_at: Time.current,
      now: Time.current,
      override: true
    }

    next_event = @scenario.check_transitions_for_event(@event1, context)
    assert_equal @event2, next_event, "Manual override should trigger Lateral Movement immediately"
  end

  test "event2 -> event3 triggers on alert_threshold" do
    # Satisfy alert_threshold with exactly 3 alerts
    context = { alerts_count: 3 }
    next_event = @scenario.check_transitions_for_event(@event2, context)
    assert_equal @event3, next_event, "3 or more alerts should trigger Detection & Triage"
  end

  test "event3 -> event4 triggers on time_elapsed" do
    # Satisfy time_elapsed (15 minutes have passed)
    context = {
      scenario_started_at: 15.minutes.ago,
      now: Time.current
    }
    next_event = @scenario.check_transitions_for_event(@event3, context)
    assert_equal @event4, next_event, "After 15 minutes of triage, should transition to Containment & Investigation"
  end

  test "event4 -> event5 triggers via flag 'containment_failed'" do
    # Simulate failed containment by setting the 'containment_failed' flag
    context = {
      flags: { "containment_failed" => true }
    }
    next_event = @scenario.check_transitions_for_event(@event4, context)
    assert_equal @event5, next_event, "Failed containment should lead to Data Exfiltration / Attack Escalation"
  end

  test "event4 -> event6 triggers when containment_successful and manual override" do
    # Simulate successful containment and manual override
    context = {
      flags: { "containment_successful" => true },
      override: true
    }
    next_event = @scenario.check_transitions_for_event(@event4, context)
    assert_equal @event6, next_event, "Successful containment with override should transition to Eradication & Recovery"
  end

  test "event5 -> event6 triggers when threat_resolved and manual override" do
    # Simulate threat resolution (set the 'threat_resolved' flag) along with manual override
    context = {
      flags: { "threat_resolved" => true },
      override: true
    }
    next_event = @scenario.check_transitions_for_event(@event5, context)
    assert_equal @event6, next_event, "Threat resolved with override should lead to final stage"
  end

  test "no transition if conditions are not met" do
    # For example, from event2 -> event3 if alerts_count < 3 and no override, no transition should occur.
    context = { alerts_count: 2 }
    next_event = @scenario.check_transitions_for_event(@event2, context)
    assert_nil next_event, "With only 2 alerts and no override, detection should not be triggered"
  end
end
