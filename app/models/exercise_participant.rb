class ExerciseParticipant < ApplicationRecord
  belongs_to :team
  belongs_to :exercise
  belongs_to :user, optional: true

  acts_as_tenant(:team)
  has_paper_trail
  attribute :role, :string, default: "participant"

  validates :name, presence: true, length: { maximum: 100 }
  validates :role, presence: true, length: { maximum: 100 }
end
