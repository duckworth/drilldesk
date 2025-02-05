Fabricator(:exercise_participant) do
  team { Current.team || Fabricate(:team) }
  exercise { Fabricate(:predefined_exercise) }
  name     { Faker::Name.name }
  user
  role { ExerciseParticipant.default_role || "participant" }
end
