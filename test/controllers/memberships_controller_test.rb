require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = Fabricate(:user)
    @user.confirm
    sign_in @user
    @membership = Fabricate(:membership, user: @user)
  end

  test "get index" do
    get memberships_url
    assert_response :success
  end

  test "get new" do
    get new_membership_url
    assert_response :success
  end

  test "create membership" do
    user_2 = Fabricate(:user)

    assert_difference("Membership.count") do
      post memberships_url, params: { membership: { preferences: @membership.preferences, role: @membership.role, team_id: @membership.team_id, user_id: user_2.id } }
    end

    assert_redirected_to membership_url(Membership.order(created_at: :desc).first)
  end

  test "show membership" do
    get membership_url(@membership)
    assert_response :success
  end

  test "get edit" do
    get edit_membership_url(@membership)
    assert_response :success
  end

  test "update membership" do
    patch membership_url(@membership), params: { membership: { preferences: @membership.preferences, role: @membership.role, team_id: @membership.team_id, user_id: @membership.user_id } }
    assert_redirected_to membership_url(@membership)
  end

  test "destroy membership" do
    assert_difference("Membership.count", -1) do
      delete membership_url(@membership)
    end

    assert_redirected_to memberships_url
  end
end
