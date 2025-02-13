module SeedData
  class ExerciseObjectives
    LIST = [
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
    ].freeze

    def self.seed
      LIST.each do |objective_attrs|
        ExerciseObjective.find_or_create_by(name: objective_attrs[:name]) do |exercise_objective|
          exercise_objective.description = objective_attrs[:description]
        end
      end

      puts "Exercise objectives seeded successfully!"
    end
  end
end
