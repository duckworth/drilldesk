# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Fetch initial user details from environment variables
email = ENV['INITIAL_USER_EMAIL']
password = ENV['INITIAL_USER_PASSWORD']

if email.present? && password.present?
  user = User.find_or_initialize_by(email: email)

  if user.new_record?
    user.first_name = email.split('@').first if user.first_name.blank? # Fallback for name
    user.password = password
    user.password_confirmation = password
    user.sys_roles = [ User::Roles::SysRole::SYS_ADMIN ]
    user.confirmed_at = Time.current # By default, mark the user as confirmed if using Devise's Confirmable

    if user.save
      puts "Seed user created! Email: #{email}, Name: #{user.first_name}"
    else
      puts "Failed to create seed user. Errors: #{user.errors.full_messages.join(', ')}"
    end
  else
    puts "User with email #{email} already exists."
  end
end
