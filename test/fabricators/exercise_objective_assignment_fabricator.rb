Fabricator(:exercise_objective_assignment) do
  team { Current.team || Fabricate(:team) }
  exercise
  exercise_objective
  priority { rand(1..100) }
end
