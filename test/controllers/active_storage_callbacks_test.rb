require "test_helper"

class ActiveStorageCallbacksTest < ActiveSupport::TestCase
  # Helper to assert that a controller has specific before filters.
  def assert_before_filters(controller_class, *expected_filters)
    before_callbacks = controller_class._process_action_callbacks.select { |cb| cb.kind == :before }
    filters = before_callbacks.map(&:filter)
    expected_filters.each do |filter|
      assert_includes filters, filter, "#{controller_class} should include before_action #{filter}"
    end
  end

  test "ActiveStorage::Blobs::RedirectController includes TeamControllerMethods callbacks" do
    assert_before_filters(
      ActiveStorage::Blobs::RedirectController,
      :authenticate_user!,
      :set_team_and_membership
    )
  end

  test "ActiveStorage::Blobs::ProxyController includes TeamControllerMethods callbacks" do
    assert_before_filters(
      ActiveStorage::Blobs::ProxyController,
      :authenticate_user!,
      :set_team_and_membership
    )
  end

  test "ActiveStorage::Representations::RedirectController includes TeamControllerMethods callbacks" do
    assert_before_filters(
      ActiveStorage::Representations::RedirectController,
      :authenticate_user!,
      :set_team_and_membership
    )
  end

  test "ActiveStorage::Representations::ProxyController includes TeamControllerMethods callbacks" do
    assert_before_filters(
      ActiveStorage::Representations::ProxyController,
      :authenticate_user!,
      :set_team_and_membership
    )
  end

  test "ActiveStorage::DirectUploadsController includes TeamControllerMethods callbacks" do
    assert_before_filters(
      ActiveStorage::DirectUploadsController,
      :authenticate_user!,
      :set_team_and_membership
    )
  end
end
