class Current < ActiveSupport::CurrentAttributes
  attribute :in_active_admin, :user, :team, :membership, :request_id
end
