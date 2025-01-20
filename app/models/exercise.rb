class Exercise < ApplicationRecord
  include Exercise::States
  belongs_to :team
  belongs_to :exercise_type
  belongs_to :scenario, polymorphic: true
  belongs_to :created_by, class_name: "User", optional: true
  has_many :exercise_objective_assignments, dependent: :destroy
  has_many :exercise_objectives, through: :exercise_objective_assignments
  has_many :exercise_participants, dependent: :destroy
  has_many :exercise_events, dependent: :destroy


  acts_as_tenant(:team)
  default_scope { order(created_at: :desc) }
  has_paper_trail

  before_validation :set_created_by, on: :create
  validates :scenario, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :purpose, length: { maximum: 2000 }

  private

  def set_created_by
    self.created_by = Current.user if new_record? && Current.user.present?
  end
end
