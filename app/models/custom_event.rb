class CustomEvent < ApplicationRecord
  belongs_to :team
  belongs_to :custom_scenario
  acts_as_tenant(:team)
  has_paper_trail
end
