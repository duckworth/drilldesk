Fabricator(:custom_scenario) do
  team { Current.team || Fabricate(:team) }
  name { "#{Faker::Hacker.verb.capitalize} #{Faker::Hipster.word.capitalize}" }
  description { Faker::TvShows::SiliconValley.quote }
  source_text { Faker::Lorem.sentence }
  exercise_type
  source_file nil
  created_by { |attrs| attrs[:team]&.users&.first || Fabricate(:user_with_team, team: attrs[:team]) }
end
