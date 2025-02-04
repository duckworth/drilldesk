Fabricator(:custom_scenario) do
  team { Current.team || Fabricate(:team) }
  name { "#{Faker::Hacker.verb.capitalize} #{Faker::Hipster.word.capitalize}" }
  description { Faker::TvShows::SiliconValley.quote }
  source_text { Faker::Lorem.sentence }
  exercise_type
  source_file nil
  created_by { |attrs| attrs[:team]&.users&.first || Fabricate(:user_with_team, team: attrs[:team]) }
end

Fabricator(:custom_scenario_with_events, from: :custom_scenario) do
  after_build do |scenario|
    3.times do |i|
      Fabricate(:custom_event, custom_scenario: scenario, sequence_order: i + 1)
    end
  end
end
