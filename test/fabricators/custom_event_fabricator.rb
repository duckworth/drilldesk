Fabricator(:custom_event) do
  team { Current.team || Fabricate(:team) }
  name { FakerHelper.generate_event_name }
  description     { Faker::Lorem.sentence }
  custom_scenario { |attrs| Fabricate(:custom_scenario, team: attrs[:team]) }
  trigger_keywords { {} }
  sequence_order   1
end
