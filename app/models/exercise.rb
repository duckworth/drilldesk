class Exercise < ApplicationRecord
  include Exercise::States
  belongs_to :team
  belongs_to :exercise_type
  belongs_to :custom_scenario, optional: true
  belongs_to :predefined_scenario, optional: true
  belongs_to :owner, class_name: "User", optional: true
  has_many :exercise_objective_assignments, dependent: :destroy
  has_many :exercise_objectives, through: :exercise_objective_assignments

  acts_as_tenant(:team)
  default_scope { order(created_at: :desc) }
  has_paper_trail

  before_validation :set_owner, on: :create
  validates :name, presence: true, length: { maximum: 255 }

  private

  def set_owner
    self.owner = Current.user if new_record? && Current.user.present?
  end
end
