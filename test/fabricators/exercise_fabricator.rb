Fabricator(:exercise) do
  team { Current.team || Fabricate(:team) }
  name { "#{Faker::Hacker.verb.capitalize} #{Faker::Hipster.word.capitalize}" }
  purpose { "#{Faker::Hacker.ingverb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}" }
  exercise_type
end

Fabricator(:exercise_with_assigned_objectives, from: :exercise) do
  after_build do |exercise|
    exercise.exercise_objective_assignments = Fabricate.times(rand(1..3), :exercise_objective_assignment, exercise: exercise)
  end
end

Fabricator(:custom_exercise, from: :exercise) do
  scenario { Fabricate(:custom_scenario) }
end

Fabricator(:predefined_exercise, from: :exercise) do
  scenario { Fabricate(:predefined_scenario) }
end
