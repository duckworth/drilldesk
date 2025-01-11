Fabricator(:exercise_type) do
  name { "#{Faker::Hacker.ingverb} type" }
  description { Faker::Hacker.say_something_smart }
  enabled true
end
