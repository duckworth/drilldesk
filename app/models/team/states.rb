# frozen_string_literal: true

class Team
  module States
    extend ActiveSupport::Concern

    included do
      aasm column: :status do
        state :active, initial: true
        state :suspended
        state :disabled

        event :suspend do
          before do
            self.suspended_at = Time.current
          end

          transitions from: [ :active ], to: :suspended
        end

        event :disable do
          before do
            self.disabled_at = Time.current
          end

          transitions from: %i[active suspended], to: :suspended
        end

        event :re_activate do
          before do
            self.suspended_at = nil
            self.disabled_at = nil
          end
          transitions from: %i[disabled suspended], to: :active
        end
      end
    end
  end
end
