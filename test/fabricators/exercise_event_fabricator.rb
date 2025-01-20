Fabricator(:exercise_event) do
  team { Current.team || Fabricate(:team) }
  exercise
  event nil
  triggered_at { Time.current }
  status
  relative_event_time { Faker::Number.number.within(range: 1..100000) }
end

Fabricator(:custom_exercise_event, from: :exercise_event) do
  event { Fabricate(:custom_exercise_event) }
end

Fabricator(:predefined_exercise_event, from: :exercise_event) do
  event { Fabricate(:predefined_exercise_event) }
end
