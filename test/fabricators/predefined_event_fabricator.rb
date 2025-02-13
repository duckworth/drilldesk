Fabricator(:predefined_event) do
  name { FakerHelper.generate_event_name }
  description { Faker::TvShows::SiliconValley.quote }
  predefined_scenario
end
