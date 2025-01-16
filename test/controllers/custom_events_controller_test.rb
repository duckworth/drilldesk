require "test_helper"

class CustomEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @custom_event = Fabricate(:custom_event)
  end

  test "should get index" do
    get custom_events_url
    assert_response :success
  end

  test "should get new" do
    get new_custom_event_url
    assert_response :success
  end

  test "should create custom_event" do
    assert_difference("CustomEvent.count") do
      post custom_events_url, params: { custom_event: { custom_scenario_id: @custom_event.custom_scenario_id, description: @custom_event.description, name: @custom_event.name, sequence_order: @custom_event.sequence_order, team_id: @custom_event.team_id, trigger_keywords: @custom_event.trigger_keywords } }
    end

    assert_redirected_to custom_event_url(CustomEvent.last)
  end

  test "should show custom_event" do
    get custom_event_url(@custom_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_custom_event_url(@custom_event)
    assert_response :success
  end

  test "should update custom_event" do
    patch custom_event_url(@custom_event), params: { custom_event: { custom_scenario_id: @custom_event.custom_scenario_id, description: @custom_event.description, name: @custom_event.name, sequence_order: @custom_event.sequence_order, team_id: @custom_event.team_id, trigger_keywords: @custom_event.trigger_keywords } }
    assert_redirected_to custom_event_url(@custom_event)
  end

  test "should destroy custom_event" do
    assert_difference("CustomEvent.count", -1) do
      delete custom_event_url(@custom_event)
    end

    assert_redirected_to custom_events_url
  end
end
