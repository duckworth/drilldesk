Fabricator(:team) do
  name Faker::Company.unique.name
end

Fabricator(:default_team, from: :team) do
  name "Default Team"
  slug "default-team"
end
