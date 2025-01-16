require "test_helper"

class PredefinedEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @predefined_event = Fabricate(:predefined_event)
  end

  test "should get index" do
    get predefined_events_url
    assert_response :success
  end

  test "should get new" do
    get new_predefined_event_url
    assert_response :success
  end

  test "should create predefined_event" do
    assert_difference("PredefinedEvent.count") do
      post predefined_events_url, params: { predefined_event: { description: @predefined_event.description, name: @predefined_event.name, predefined_scenario_id: @predefined_event.predefined_scenario_id, trigger_conditions: @predefined_event.trigger_conditions } }
    end

    assert_redirected_to predefined_event_url(PredefinedEvent.last)
  end

  test "should show predefined_event" do
    get predefined_event_url(@predefined_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_predefined_event_url(@predefined_event)
    assert_response :success
  end

  test "should update predefined_event" do
    patch predefined_event_url(@predefined_event), params: { predefined_event: { description: @predefined_event.description, name: @predefined_event.name, predefined_scenario_id: @predefined_event.predefined_scenario_id, trigger_conditions: @predefined_event.trigger_conditions } }
    assert_redirected_to predefined_event_url(@predefined_event)
  end

  test "should destroy predefined_event" do
    assert_difference("PredefinedEvent.count", -1) do
      delete predefined_event_url(@predefined_event)
    end

    assert_redirected_to predefined_events_url
  end
end
