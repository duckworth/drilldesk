require Rails.root.join("db/seeds/common/000200_exercise_types.rb")

Fabricator(:exercise_type) do
  transient :exercise_data

  exercise_data { SeedData::ExerciseTypes::LIST.sample }

  name { |attrs| attrs[:exercise_data][:name] }
  description { |attrs| attrs[:exercise_data][:description] }

  enabled { true }
end
