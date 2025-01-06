class AddFlipperRegistrationFeature < ActiveRecord::Migration[8.0]
  def up
    # Check existence and add `registration` feature if not already present
    unless Flipper.exist?(:registration)
      Flipper.enable(:registration)
    end
  end

  def down
    # Optionally disable or remove the feature during rollback (if needed)
    if Flipper.exist?(:registration)
      Flipper.disable(:registration)
    end
  end
end
