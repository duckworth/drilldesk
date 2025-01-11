Fabricator(:exercise_objective) do
  name { "#{Faker::Hacker.ingverb} objective" }
  description { Faker::Hacker.say_something_smart }
  enabled     true
end
