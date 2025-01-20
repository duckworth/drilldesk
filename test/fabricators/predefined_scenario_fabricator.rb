Fabricator(:predefined_scenario) do
  name { FakerHelper.generate_contextual_event_name }
  description { Faker::TvShows::SiliconValley.quote }
  exercise_type
  starting_scenario_event nil
end

Fabricator(:predefined_scenario_with_events, from: :predefined_scenario) do
  after_create do |scenario|
    Fabricate.times(3, :predefined_exercise_event, exercise: scenario.exercise)
  end
end
