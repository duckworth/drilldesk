Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.unique.email(domain: "drilldesk.com") }
  password { Faker::Internet.password(min_length: 8, max_length: 12, mix_case: true, special_characters: true) }
end

Fabricator(:confirmed_user, from: :user) do
  confirmed_at { Time.current }
end

Fabricator(:user_with_team, from: :user) do
  after_build do |user|
    user.membership ||= Fabricate(:membership, user: user)
  end
end
