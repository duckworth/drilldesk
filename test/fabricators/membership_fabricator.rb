Fabricator(:membership) do
  team
  user { Fabricate(:confirmed_user) }
  role "owner"
  preferences { }
end
