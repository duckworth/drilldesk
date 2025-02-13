module SeedData
  class ExerciseTypes
    LIST = [
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
    ].freeze

    def self.seed
      LIST.each do |exercise_type_attrs|
        ExerciseType.find_or_create_by(name: exercise_type_attrs[:name]) do |exercise_type|
          exercise_type.description = exercise_type_attrs[:description]
        end
      end

      puts "Exercise types seeded successfully!"
    end
  end
end
