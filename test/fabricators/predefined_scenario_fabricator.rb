Fabricator(:predefined_scenario) do
  name { FakerHelper.generate_contextual_event_name }
  description { Faker::TvShows::SiliconValley.quote }
  exercise_type
  starting_scenario_event nil
end

Fabricator(:predefined_scenario_with_events, from: :predefined_scenario) do
  after_build do |scenario|
    Fabricate.times(3, :predefined_event, predefined_scenario: scenario)
    scenario.starting_scenario_event = scenario.predefined_events.sample
  end
end

Fabricator(:predefined_scenario_apt_intrusion, class_name: :predefined_scenario) do
  name { "APT Intrusion (Advanced Persistent Threat)" }
  description do
    "A multi-stage, stealthy cyber attack involving infiltration, lateral movement, data exfiltration, " \
      "and incident response activities."
  end
  enabled { true }
  exercise_type do
    Fabricate(:exercise_type,
              name: "Cybersecurity Incident Response",
              description: "Evaluate the organization's ability to detect, respond to, and recover from cybersecurity incidents.",
              enabled: true)
  end

  after_create do |scenario|
    # Create the six events with their fixed names and descriptions.
    event1 = Fabricate(:predefined_event,
                       predefined_scenario: scenario,
                       name: "Initial Compromise",
                       description: <<~DESC.strip
                         Attackers gain a foothold through phishing or a zero-day exploit.
                         Key indicators might be suspicious PowerShell commands, unusual outbound network traffic,
                         or a triggered alert from endpoint security. The organization is unaware of the intrusion at this point.
                       DESC
    )
    event2 = Fabricate(:predefined_event,
                       predefined_scenario: scenario,
                       name: "Lateral Movement",
                       description: <<~DESC.strip
                         The attacker moves deeper into the network, escalating privileges, creating new accounts,
                         and probing internal systems. The breach is still unnoticed by the security team.
                       DESC
    )
    event3 = Fabricate(:predefined_event,
                       predefined_scenario: scenario,
                       name: "Detection & Triage",
                       description: <<~DESC.strip
                         Security detects suspicious authentication patterns or endpoint alerts.
                         The SOC escalates to the Incident Response (IR) team for initial triage and validation.
                       DESC
    )
    event4 = Fabricate(:predefined_event,
                       predefined_scenario: scenario,
                       name: "Containment & Investigation",
                       description: <<~DESC.strip
                         IR team attempts to contain the attack, blocking malicious IPs and isolating compromised machines.
                         They also begin a deeper investigation to determine the attack scope.
                       DESC
    )
    event5 = Fabricate(:predefined_event,
                       predefined_scenario: scenario,
                       name: "Data Exfiltration / Attack Escalation (Branch)",
                       description: <<~DESC.strip
                         If containment fails or is delayed, the attacker exfiltrates sensitive data or initiates a ransomware move.
                         This can trigger crisis communications, legal obligations, or further damage.
                       DESC
    )
    event6 = Fabricate(:predefined_event,
                       predefined_scenario: scenario,
                       name: "Eradication, Recovery & Post-Incident",
                       description: <<~DESC.strip
                         Final stage: IR removes malicious artifacts, closes intrusion vectors, and restores systems.
                         A post-incident review captures lessons learned, finalizing official reporting and root cause analysis.
                       DESC
    )

    # Set the scenario’s starting event (we choose event1 as in the seed)
    scenario.update(starting_scenario_event: event1)

    # Create the transitions.
    # Transition: Event1 -> Event2
    Fabricate(:predefined_event_transition,
              from_event: event1,
              to_event: event2,
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

    # Transition: Event2 -> Event3
    Fabricate(:predefined_event_transition,
              from_event: event2,
              to_event: event3,
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

    # Transition: Event3 -> Event4
    Fabricate(:predefined_event_transition,
              from_event: event3,
              to_event: event4,
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

    # Transition: Event4 -> Event5 (Failed Containment Path)
    Fabricate(:predefined_event_transition,
              from_event: event4,
              to_event: event5,
              condition: {
                logic: "OR",
                conditions: [
                  {
                    type: "flag_set",
                    value: "containment_failed",
                    description: "If IR team’s containment is insufficient, set the 'containment_failed' flag."
                  },
                  {
                    type: "time_elapsed",
                    value: "PT20M",
                    description: "If containment is delayed beyond 20 minutes, assume escalation."
                  }
                ]
              }
    )

    # Transition: Event4 -> Event6 (Successful Containment Path)
    Fabricate(:predefined_event_transition,
              from_event: event4,
              to_event: event6,
              condition: {
                logic: "AND",
                conditions: [
                  {
                    type: "flag_set",
                    value: "containment_successful",
                    description: "IR team demonstrates effective isolation. Set the 'containment_successful' flag."
                  },
                  {
                    type: "manual_override",
                    value: true,
                    description: "Facilitator decides to proceed to final stage."
                  }
                ]
              }
    )

    # Transition: Event5 -> Event6
    Fabricate(:predefined_event_transition,
              from_event: event5,
              to_event: event6,
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
  end
end
