class Interaction < ApplicationRecord
  belongs_to :team
  belongs_to :exercise
  belongs_to :exercise_event
  belongs_to :user
  acts_as_tenant(:team)
  has_paper_trail
  enum :interaction_type, { question: 1, command: 2, statement: 3, clarification: 4, feedback: 5 }
end
