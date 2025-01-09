Fabricator(:membership) do
  team
  user
  role "owner"
  preferences { }
end
