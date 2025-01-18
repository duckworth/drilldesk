class CustomEvent < Event
  belongs_to :team
  acts_as_tenant(:team)
  belongs_to :custom_scenario
end
