# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Fetch initial user details from environment variables
email = ENV['INITIAL_USER_EMAIL']
password = ENV['INITIAL_USER_PASSWORD']

if email.present? && password.present?
  user = User.find_or_initialize_by(email: email)

  if user.new_record?
    user.name = email.split('@').first if user.name.blank? # Fallback for name
    user.password = password
    user.password_confirmation = password
    user.sys_roles = [ User::Roles::SysRole::SYS_ADMIN ]
    user.confirmed_at = Time.current # By default, mark the user as confirmed if using Devise's Confirmable

    if user.save
      puts "Seed user created! Email: #{email}, Name: #{user.name}"
    else
      puts "Failed to create seed user. Errors: #{user.errors.full_messages.join(', ')}"
    end
  else
    puts "User with email #{email} already exists."
  end
end

team = Team.find_or_create_by(slug: 'default-team') do |t|
  t.name = 'Default Team'
  t.is_test = true
end

if email.present?
  if (user = User.find_by(email: email))
    Membership.find_or_create_by(user: user, team: team) do |membership|
      membership.role = 'owner'
    end
  end
end

require_relative "seeds/seed_registry"
# Load the seed files (alphabetically ordered)
seed_files = Dir[Rails.root.join('db', 'seeds', 'common', '*.rb')].sort
seed_files.each { |file| require file }

# Call seed_all to run seeds in the order in which they registered themselves
SeedData.seed_all


# load environment-specific seed file
environment_seed_file = Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb")
load(environment_seed_file) if File.exist?(environment_seed_file)
