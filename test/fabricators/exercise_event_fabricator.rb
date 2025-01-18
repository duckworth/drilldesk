Fabricator(:exercise_event) do
  team                nil
  exercise            nil
  event nil
  triggered_at        { Time.current }
  status
  relative_event_time { Faker::Number.number.within(range: 1..100000) }
end

Fabricate(:custom_exercise_event, from: :exercise_event) do
  event { Fabricate(:custom_exercise_event) }
end

Fabricate(:predefined_exercise_event, from: :exercise_event) do
  event { Fabricate(:predefined_exercise_event) }
end
