Fabricator(:exercise_participant) do
  team { Current.team || Fabricate(:team) }
  exercise nil
  name     "MyString"
  user     nil
  role     "MyString"
end
