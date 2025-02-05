class ExerciseArtifact < ApplicationRecord
  include FileConstraints

  belongs_to :team
  belongs_to :exercise
  has_one_attached :file
  acts_as_tenant(:team)
  has_paper_trail

  enum :artifact_type, { input_policy: 1, detail_report: 2, summary_report: 3 }

  validates :artifact_type, presence: true
  validates :file, presence: true,
            content_type: { in: ACCEPTED_FILE_EXTENSIONS, spoofing_protection: false },
            size: { less_than_or_equal_to: MAX_FILE_SIZE }
end
