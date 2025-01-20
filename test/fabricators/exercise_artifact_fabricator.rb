Fabricator(:exercise_artifact) do
  team { Current.team || Fabricate(:team) }
  exercise      nil
  artifact_type "MyString"
  file          nil
end
