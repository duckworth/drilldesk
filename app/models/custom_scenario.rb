class CustomScenario < Scenario
  belongs_to :team
  belongs_to :created_by, class_name: "User"
  has_one_attached :source_file
  has_many :custom_events
  has_many :exercises
  acts_as_tenant(:team)
  default_scope { order(id: :desc) }
  has_paper_trail

  before_validation :set_created_by, on: :create


  include AASM
  aasm column: :status do
    state :draft, initial: true
    state :enabled
    state :archived

    event :enable do
      transitions from: [ :draft, :disabled ], to: :enabled
    end

    event :archive do
      transitions from: [ :draft, :enabled ], to: :archived
    end
  end


  private

  def set_created_by
    self.created_by = Current.user if new_record? && Current.user.present?
  end
end
