Fabricator(:predefined_event_transition) do
  from_event { Fabricate(:predefined_event) }
  to_event { |attrs| Fabricate(:predefined_event, predefined_scenario: attrs[:from_event].predefined_scenario) }
  condition  ""
end
