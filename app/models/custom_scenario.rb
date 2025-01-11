class CustomScenario < ApplicationRecord
  belongs_to :team
  belongs_to :exercise_type
  belongs_to :created_by, class_name: "User"
  has_one_attached :source_file
  before_validation :set_created_by, on: :create
  acts_as_tenant(:team)
  default_scope { order(created_at: :desc) }
  has_paper_trail

  private

  def set_created_by
    self.created_by = Current.user if new_record? && Current.user.present?
  end
end
