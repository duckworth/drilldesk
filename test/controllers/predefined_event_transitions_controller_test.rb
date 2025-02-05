require "test_helper"

class PredefinedEventTransitionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user, @team = user_with_team
    @user.update(sys_roles: [ User::Roles::SysRole::SYS_ADMIN ])
    sign_in @user
    @predefined_event_transition = Fabricate(:predefined_event_transition)
  end

  test "should get index" do
    get predefined_event_transitions_url
    assert_response :success
  end

  test "should get new" do
    get new_predefined_event_transition_url
    assert_response :success
  end

  test "should create predefined_event_transition" do
    assert_difference("PredefinedEventTransition.count") do
      post predefined_event_transitions_url, params: { predefined_event_transition: { condition: @predefined_event_transition.condition, from_event_id: @predefined_event_transition.from_event_id, to_event_id: @predefined_event_transition.to_event_id } }
    end

    assert_redirected_to predefined_event_transition_url(PredefinedEventTransition.last)
  end

  test "should show predefined_event_transition" do
    get predefined_event_transition_url(@predefined_event_transition)
    assert_response :success
  end

  test "should get edit" do
    get edit_predefined_event_transition_url(@predefined_event_transition)
    assert_response :success
  end

  test "should update predefined_event_transition" do
    patch predefined_event_transition_url(@predefined_event_transition), params: { predefined_event_transition: { condition: @predefined_event_transition.condition, from_event_id: @predefined_event_transition.from_event_id, to_event_id: @predefined_event_transition.to_event_id } }
    assert_redirected_to predefined_event_transition_url(@predefined_event_transition)
  end

  test "should destroy predefined_event_transition" do
    assert_difference("PredefinedEventTransition.count", -1) do
      delete predefined_event_transition_url(@predefined_event_transition)
    end

    assert_redirected_to predefined_event_transitions_url
  end
end
