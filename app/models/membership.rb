class Membership < ApplicationRecord
  belongs_to :team
  belongs_to :user
  # acts_as_tenant(:team)
end
