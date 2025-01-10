require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = Fabricate(:user)
    @user.confirm
    sign_in @user
    @membership = Fabricate(:membership, user: @user)
  end

  def test_get_index
    get memberships_url
    assert_response :success
  end

  def test_get_new
    get new_membership_url
    assert_response :success
  end

  def test_create_membership
    user_2 = Fabricate(:user)

    assert_difference("Membership.count") do
      post memberships_url, params: { membership: { preferences: @membership.preferences, role: @membership.role, team_id: @membership.team_id, user_id: user_2.id } }
    end

    assert_redirected_to membership_url(Membership.order(created_at: :desc).first)
  end

  def test_show_membership
    get membership_url(@membership)
    assert_response :success
  end

  def test_get_edit
    get edit_membership_url(@membership)
    assert_response :success
  end

  def test_update_membership
    patch membership_url(@membership), params: { membership: { preferences: @membership.preferences, role: @membership.role, team_id: @membership.team_id, user_id: @membership.user_id } }
    assert_redirected_to membership_url(@membership)
  end

  def test_destroy_membership
    assert_difference("Membership.count", -1) do
      delete membership_url(@membership)
    end

    assert_redirected_to memberships_url
  end
end
