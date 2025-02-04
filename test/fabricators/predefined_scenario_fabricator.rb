Fabricator(:predefined_scenario) do
  name { FakerHelper.generate_contextual_event_name }
  description { Faker::TvShows::SiliconValley.quote }
  exercise_type
  starting_scenario_event nil
end

Fabricator(:predefined_scenario_with_events, from: :predefined_scenario) do
  after_build do |scenario|
    Fabricate.times(3, :predefined_event, predefined_scenario: scenario)
    scenario.starting_scenario_event = scenario.predefined_events.sample
  end
end
