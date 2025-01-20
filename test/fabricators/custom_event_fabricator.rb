Fabricator(:custom_event) do
  team { Current.team || Fabricate(:team) }
  name { FakerHelper.generate_event_name }
  description      "MyText"
  custom_scenario  nil
  name             "MyString"
  trigger_keywords ""
  sequence_order   1
end
