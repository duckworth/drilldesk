require "test_helper"

class InteractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user, @team = user_with_team
    sign_in @user
    @interaction = Fabricate(:interaction)
  end

  test "should get index" do
    get interactions_url
    assert_response :success
  end

  test "should get new" do
    get new_interaction_url
    assert_response :success
  end

  test "should create interaction" do
    assert_difference("Interaction.count") do
      post interactions_url, params: { interaction: { ai_response: @interaction.ai_response, exercise_event_id: @interaction.exercise_event_id, exercise_id: @interaction.exercise_id, interaction_type: @interaction.interaction_type, response_confidence: @interaction.response_confidence, team_id: @interaction.team_id, user_id: @interaction.user_id, user_input: @interaction.user_input } }
    end

    assert_redirected_to interaction_url(Interaction.last)
  end

  test "should show interaction" do
    get interaction_url(@interaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_interaction_url(@interaction)
    assert_response :success
  end

  test "should update interaction" do
    patch interaction_url(@interaction), params: { interaction: { ai_response: @interaction.ai_response, exercise_event_id: @interaction.exercise_event_id, exercise_id: @interaction.exercise_id, interaction_type: @interaction.interaction_type, response_confidence: @interaction.response_confidence, team_id: @interaction.team_id, user_id: @interaction.user_id, user_input: @interaction.user_input } }
    assert_redirected_to interaction_url(@interaction)
  end

  test "should destroy interaction" do
    assert_difference("Interaction.count", -1) do
      delete interaction_url(@interaction)
    end

    assert_redirected_to interactions_url
  end
end
