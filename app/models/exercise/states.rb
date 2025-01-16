class Exercise
  module States
    extend ActiveSupport::Concern

    included do
      includes AASM
      aasm column: :status do
        state :not_started, initial: true
        state :in_progress
        state :exercised
        state :retrospecting
        state :retrospected

        event :start do
          before do
            self.in_progress_at = Time.current
          end

          transitions from: [ :not_started ], to: :in_progress
        end

        event :complete_exercise do
          before do
            self.exercised_at = Time.current
          end

          transitions from: [ :in_progress ], to: :exercised
        end

        event :start_retrospect do
          before do
            self.retrospecting_at = Time.current
          end

          transitions from: [ :exercised ], to: :retrospecting
        end

        event :complete_retrospect do
          before do
            self.retrospected_at = Time.current
          end

          transitions from: [ :retrospecting ], to: :retrospected
        end

        event :restart_exercise do
          before do
            self.exercised_at = nil
          end
          transitions from: [ :exercised ], to: :in_progress
        end
      end
    end
  end
end
