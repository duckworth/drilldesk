require "application_system_test_case"

class MembershipsTest < ApplicationSystemTestCase
  setup do
    @membership = Fabricate(:membership)
    @user = @membership.user
    sign_in @user
  end

  def test_visiting_index
    visit memberships_url
    assert_selector "h1", text: "Memberships"
  end

  def test_creating_Membership
    user_2 = Fabricate(:user)
    visit memberships_url
    click_on "New membership"

    fill_in "Preferences", with: @membership.preferences
    fill_in "Role", with: @membership.role
    fill_in "Team", with: @membership.team_id
    fill_in "User", with: user_2.id
    click_on "Create Membership"

    assert_text "Membership was successfully created"
    click_on "Back"
  end

  def test_updating_Membership
    visit membership_url(@membership)
    click_on "Edit this membership", match: :first

    fill_in "Preferences", with: @membership.preferences
    fill_in "Role", with: @membership.role
    fill_in "Team", with: @membership.team_id
    fill_in "User", with: @membership.user_id
    click_on "Update Membership"

    assert_text "Membership was successfully updated"
    click_on "Back"
  end

  def test_destroying_Membership
    visit membership_url(@membership)
    click_on "Destroy this membership", match: :first

    assert_text "Membership was successfully destroyed"
  end
end
