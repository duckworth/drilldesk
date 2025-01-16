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

# Seed data for Exercise Types
exercise_types = [
  {
    name: "Cybersecurity Incident Response",
    description: "Evaluate the organization's ability to detect, respond to, and recover from cybersecurity incidents."
  },
  {
    name: "Business Continuity",
    description: "Assess the capability to maintain critical business functions during and after a disruptive event."
  },
  {
    name: "Disaster Recovery",
    description: "Evaluate the organization's preparedness and effectiveness in recovering systems and data following a major disruption."
  },
  {
    name: "Crisis Management",
    description: "Test the organization's ability to coordinate and make decisions during a crisis that impacts operations or stakeholders."
  },
  {
    name: "Physical Security",
    description: "Assess the measures in place to protect physical assets and personnel against security threats."
  },
  {
    name: "Regulatory Compliance",
    description: "Evaluate adherence to relevant regulatory requirements and internal compliance standards."
  },
  {
    name: "Supply Chain Resilience",
    description: "Assess the organization's preparedness for managing disruptions in the supply chain and ensuring operational continuity."
  },
  {
    name: "Pandemic Preparedness",
    description: "Evaluate the organization's readiness to manage large-scale health-related disruptions."
  }
]

exercise_types.each do |exercise_type_attrs|
  ExerciseType.find_or_create_by(name: exercise_type_attrs[:name]) do |exercise_type|
    exercise_type.description = exercise_type_attrs[:description]
    exercise_type.enabled = true  # Assuming the 'enabled' column corresponds to 'is_active'
  end
end

puts "Exercise types seeded successfully!"


# Seed data for Exercise Objectives
exercise_objectives = [
  {
    name: "Compliance Check",
    description: "Evaluate adherence to existing regulatory standards and compliance requirements within the organization."
  },
  {
    name: "Preparedness Review",
    description: "Assess the readiness of all relevant teams to respond effectively to emergency or crisis scenarios."
  },
  {
    name: "Gap Analysis",
    description: "Identify and document deficiencies in the current security or response plan compared to industry best practices."
  },
  {
    name: "Role Assignment",
    description: "Verify that each participant understands and is capable of executing their assigned roles effectively during the exercise."
  },
  {
    name: "Communication Test",
    description: "Evaluate the efficiency and effectiveness of internal and external communication channels during the exercise."
  },
  {
    name: "Decision Skill Building",
    description: "Enhance decision-making abilities by simulating high-pressure scenarios requiring critical choices."
  },
  {
    name: "Detection Evaluation",
    description: "Assess the organization's ability to detect, identify, and analyze security incidents or anomalies."
  },
  {
    name: "Recovery Planning",
    description: "Test the effectiveness of the disaster recovery plan to ensure rapid restoration of critical systems and services."
  },
  {
    name: "Cybersecurity Training",
    description: "Provide participants with hands-on training to improve awareness and skills related to cybersecurity threats and mitigations."
  },
  {
    name: "Post-Exercise Action Plan",
    description: "Develop actionable steps to address identified gaps and enhance overall resilience after the exercise."
  }
]

exercise_objectives.each do |objective_attrs|
  ExerciseObjective.find_or_create_by(name: objective_attrs[:name]) do |exercise_objective|
    exercise_objective.description = objective_attrs[:description]
    exercise_objective.enabled = true # Assuming 'enabled' corresponds to 'is_active'
  end
end

puts "Exercise objectives seeded successfully!"


# load environment-specific seed file
environment_seed_file = Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb")
load(environment_seed_file) if File.exist?(environment_seed_file)
