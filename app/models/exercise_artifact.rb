class ExerciseArtifact < ApplicationRecord
  belongs_to :team
  belongs_to :exercise
  has_one_attached :file
  acts_as_tenant(:team)
  has_paper_trail

  enum :artifact_type, { input_policy: 1, detail_report: 2, summary_report: 3 }
end
