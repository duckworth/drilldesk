class PredefinedEventTransition < ApplicationRecord
  belongs_to :from_event, class_name: "PredefinedEvent"
  belongs_to :to_event, class_name: "PredefinedEvent"
end
