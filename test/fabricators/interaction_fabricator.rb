Fabricator(:interaction) do
  team { Current.team || Fabricate(:team) }
  exercise            nil
  exercise_event      nil
  interaction_type    "MyString"
  user                nil
  user_input          ""
  ai_response         ""
  response_confidence 1.5
end
