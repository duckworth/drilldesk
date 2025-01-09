Fabricator(:user_base, class_name: "User") do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.unique.email(domain: "drilldesk.com") }
  password { Faker::Internet.password(min_length: 8, max_length: 12, mix_case: true, special_characters: true) }
  password_confirmation { |attrs| attrs[:password] }
end

Fabricator(:user, from: :user_base) do
  confirmed_at { Time.current }
end

Fabricator(:unconfirmed_user, from: :user_base) do
  # confirmed_at { nil }
end

Fabricator(:user_with_team, from: :user) do
  after_build do |user|
    user.membership ||= Fabricate(:membership, user: user)
  end
end
