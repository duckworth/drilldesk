Fabricator(:custom_scenario) do
  team
  name { "#{Faker::Hacker.verb.capitalize} #{Faker::Hipster.word.capitalize}" }
  description { Faker::SiliconValley.quote }
  source_text { Faker::Lorem.sentence }
  exercise_type
  source_file nil
  created_by { |attrs| attrs[:team]&.users&.first }
end
