Fabricator(:interaction) do
  team { Current.team || Fabricate(:team) }
  exercise_event { Fabricate(:predefined_exercise_event) }
  exercise { |attrs| attrs[:exercise_event].exercise }
  interaction_type { Interaction.interaction_types.keys.sample }
  user { |attrs| Current.user || Fabricate(:user_with_team, team: attrs[:team]) }
  user_input { Faker::Hacker.say_something_smart }
  ai_response { Faker::Hacker.say_something_smart }
  response_confidence { Faker::Number.decimal(l_digits: 2) }
end
