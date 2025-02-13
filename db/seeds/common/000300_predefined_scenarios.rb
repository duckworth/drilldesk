module SeedData
  class PredefinedScenarios
    def self.seed
      # 1) Make sure you have your ExerciseType, ExerciseObjectives, etc. seeded:
      #    We'll assume "Cybersecurity Incident Response" already exists and is enabled.

      cyber_ex_type = ExerciseType.find_by!(name: "Cybersecurity Incident Response")

      # 2) Create the robust PredefinedScenario (APT intrusion).
      apt_scenario = PredefinedScenario.create!(
        name: "APT Intrusion (Advanced Persistent Threat)",
        description: "A multi-stage, stealthy cyber attack involving infiltration, lateral movement, data exfiltration, and incident response activities.",
        enabled: true,
        exercise_type_id: cyber_ex_type.id
        # We'll update starting_scenario_event_id after we create the first event
      )

      # 3) Create PredefinedEvents (no trigger_conditions; transitions handle logic).
      event1 = PredefinedEvent.create!(
        predefined_scenario_id: apt_scenario.id,
        name: "Initial Compromise",
        description: <<~DESC
          Attackers gain a foothold through phishing or a zero-day exploit.
          Key indicators might be suspicious PowerShell commands, unusual outbound network traffic,
          or a triggered alert from endpoint security. The organization is unaware of the intrusion at this point.
        DESC
      )

      event2 = PredefinedEvent.create!(
        predefined_scenario_id: apt_scenario.id,
        name: "Lateral Movement",
        description: <<~DESC
          The attacker moves deeper into the network, escalating privileges, creating new accounts,
          and probing internal systems. The breach is still unnoticed by the security team.
        DESC
      )

      event3 = PredefinedEvent.create!(
        predefined_scenario_id: apt_scenario.id,
        name: "Detection & Triage",
        description: <<~DESC
          Security detects suspicious authentication patterns or endpoint alerts.
          The SOC escalates to the Incident Response (IR) team for initial triage and validation.
        DESC
      )

      event4 = PredefinedEvent.create!(
        predefined_scenario_id: apt_scenario.id,
        name: "Containment & Investigation",
        description: <<~DESC
          IR team attempts to contain the attack, blocking malicious IPs and isolating compromised machines.
          They also begin a deeper investigation to determine the attack scope.
        DESC
      )

      event5 = PredefinedEvent.create!(
        predefined_scenario_id: apt_scenario.id,
        name: "Data Exfiltration / Attack Escalation (Branch)",
        description: <<~DESC
          If containment fails or is delayed, the attacker exfiltrates sensitive data or initiates a ransomware move.
          This can trigger crisis communications, legal obligations, or further damage.
        DESC
      )

      event6 = PredefinedEvent.create!(
        predefined_scenario_id: apt_scenario.id,
        name: "Eradication, Recovery & Post-Incident",
        description: <<~DESC
          Final stage: IR removes malicious artifacts, closes intrusion vectors, and restores systems.
          A post-incident review captures lessons learned, finalizing official reporting and root cause analysis.
        DESC
      )

      # 4) Set the scenario’s starting event
      apt_scenario.update!(starting_scenario_event_id: event1.id)

      # 5) Define PredefinedEventTransitions with generic condition types.

      # a) Event1 -> Event2
      PredefinedEventTransition.create!(
        from_event_id: event1.id,
        to_event_id: event2.id,
        condition: {
          logic: "OR",
          conditions: [
            {
              type: "time_elapsed",
              value: "PT10M", # e.g. 10 minutes from scenario start
              description: "If participants do not detect or act, the threat automatically moves laterally."
            },
            {
              type: "manual_override",
              value: true,
              description: "Facilitator can advance if it makes sense to proceed faster."
            }
          ]
        }
      )

      # b) Event2 -> Event3
      PredefinedEventTransition.create!(
        from_event_id: event2.id,
        to_event_id: event3.id,
        condition: {
          logic: "OR",
          conditions: [
            {
              # example: if we have "alert_threshold" type,
              # 'value' = 3 means "need at least 3 critical alerts"
              type: "alert_threshold",
              value: 3,
              description: "If 3 or more high-severity alerts occur, detection happens."
            },
            {
              type: "manual_override",
              value: true,
              description: "Facilitator triggers if participants discover the intrusion logically."
            }
          ]
        }
      )

      # c) Event3 -> Event4
      PredefinedEventTransition.create!(
        from_event_id: event3.id,
        to_event_id: event4.id,
        condition: {
          logic: "OR",
          conditions: [
            {
              type: "time_elapsed",
              value: "PT15M",
              description: "After 15 minutes of triage, move to official containment."
            },
            {
              type: "manual_override",
              value: true,
              description: "Facilitator can expedite if team is ready."
            }
          ]
        }
      )

      # d) Event4 -> Event5 (Failed Containment Path)
      PredefinedEventTransition.create!(
        from_event_id: event4.id,
        to_event_id: event5.id,
        condition: {
          "logic" => "OR",
          "conditions" => [
            {
              "type" => "flag_set",
              "value" => "containment_failed",
              "description" => "If IR team’s containment is insufficient, set the 'containment_failed' flag."
            },
            {
              "type" => "time_elapsed",
              "value" => "PT20M",
              "description" => "If containment is delayed beyond 20 minutes, assume escalation."
            }
          ]
        }
      )

      # e) Event4 -> Event6 (Successful Containment Path)
      PredefinedEventTransition.create!(
        from_event_id: event4.id,
        to_event_id: event6.id,
        condition: {
          "logic" => "AND",
          "conditions" => [
            {
              "type" => "flag_set",
              "value" => "containment_successful",
              "description" => "IR team demonstrates effective isolation. Set the 'containment_successful' flag."
            },
            {
              "type" => "manual_override",
              "value" => true,
              "description" => "Facilitator decides to proceed to final stage."
            }
          ]
        }
      )

      # f) Event5 -> Event6
      PredefinedEventTransition.create!(
        from_event_id: event5.id,
        to_event_id: event6.id,
        condition: {
          logic: "AND",
          conditions: [
            {
              type: "flag_set",
              value: "threat_resolved",
              description: "Attacker's exfil or ransomware threat is mitigated (the 'threat_resolved' flag is set)."
            },
            {
              type: "manual_override",
              value: true,
              description: "Facilitator can move to final stage after threat resolution."
            }
          ]
        }
      )

      puts "Predefined scenarios seeded successfully!"
    end
  end
end
