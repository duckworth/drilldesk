class Membership < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_paper_trail
  # acts_as_tenant(:team)
end
