module ActiveAdminActions
  extend ActiveSupport::Concern

  included do
    before_action -> { Current.in_active_admin = true }
    after_action -> { Current.in_active_admin = false }
  end
end
