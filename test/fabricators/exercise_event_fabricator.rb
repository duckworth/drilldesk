Fabricator(:exercise_event) do
  team { Current.team || Fabricate(:team) }
  exercise
  event nil
  triggered_at { Time.current }
  relative_event_time { Faker::Number.within(range: 1..100000) }
end

Fabricator(:custom_exercise_event, from: :exercise_event) do
  exercise { Fabricate(:custom_exercise) }
  event { Fabricate(:custom_event) }
end

Fabricator(:predefined_exercise_event, from: :exercise_event) do
  exercise { Fabricate(:predefined_exercise) }
  event { |attrs| attrs[:exercise].scenario.starting_scenario_event }
end
