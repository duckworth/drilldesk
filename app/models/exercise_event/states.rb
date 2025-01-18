module ExerciseEvent::States
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :status do
      state :pending, initial: true
      state :triggered
      state :completed

      event :trigger do
        before do
          self.triggered_at = Time.current
        end

        transitions from: :pending, to: :triggered
      end

      event :complete do
        transitions from: :triggered, to: :completed
      end
    end
  end
end
