require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = Fabricate(:user)
  end
  test "settings" do
    @user.last_team_id = "801aaf04-5d88-46a9-9fac-4b4527842c3f"
    @user.save
    assert_equal User.find(@user.id).last_team_id, "801aaf04-5d88-46a9-9fac-4b4527842c3f"
  end
end
