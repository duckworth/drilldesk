require Rails.root.join("db/seeds/common/exercise_objectives.rb")
Fabricator(:exercise_objective) do
  transient :exercise_data

  exercise_data { SeedData::ExerciseObjectives::LIST.sample }
  name { |attrs| attrs[:exercise_data][:name] }
  description { |attrs| attrs[:exercise_data][:description] }

  enabled { true }
end
