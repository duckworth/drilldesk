class Event < ApplicationRecord
  self.abstract_class = true

  has_paper_trail
  has_many :exercise_events, as: :event
end
