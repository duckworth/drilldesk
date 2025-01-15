require "test_helper"

class ActiveStorageAuthIntegrationTest < ActionDispatch::IntegrationTest
  test "unauthenticated user can not access attached file" do
    # ActiveRecord::Base.logger = Logger.new(STDOUT) # Enable SQL logging temporarily
    @user, @team = user_with_team
    @custom_scenario = Fabricate(:custom_scenario, team: @team, created_by: @user)

    # Attach a file to the custom_scenario
    file_path = Rails.root.join("test/fixtures/files/test.pdf")
    # Use file_fixture to access the file
    pdf_file = file_fixture("test.pdf")

    # Attach the file to the custom_scenario
    @custom_scenario.source_file.attach(
      io: pdf_file.open,  # Open the file for reading
      filename: pdf_file.basename.to_s,
      content_type: "application/pdf"
    )
    # Generate the URL for the attached file; this will hit Active Storage controllers.
    file_url = rails_blob_path(@custom_scenario.source_file, disposition: "attachment", only_path: true)

    # Issue a GET request to the file URL
    get file_url
    assert_response :unauthorized

    # try wrong team
    @user2, @team2 = user_with_team
    sign_in @user2
    get file_url
    assert_response :not_found # acts_as_tenant scope will filter out the record
  end

  test "authenticated user can access attached file" do
    @user, @team = user_with_team
    sign_in @user
    @custom_scenario = Fabricate(:custom_scenario, team: @team, created_by: @user)

    # Attach a file to the custom_scenario
    file_path = Rails.root.join("test/fixtures/files/test.pdf")
    # Use file_fixture to access the file
    pdf_file = file_fixture("test.pdf")

    # Attach the file to the custom_scenario
    @custom_scenario.source_file.attach(
      io: pdf_file.open,  # Open the file for reading
      filename: pdf_file.basename.to_s,
      content_type: "application/pdf"
    )
    # Generate the URL for the attached file; this will hit Active Storage controllers.
    file_url = rails_blob_path(@custom_scenario.source_file, disposition: "attachment", only_path: true)

    # Issue a GET request to the file URL
    get file_url
    # Expect a redirect (HTTP 302) as part of Active Storage's flow.
    assert_response :redirect

    # Follow the first redirect.
    follow_redirect!

    # Assert that the response is successful (HTTP 200)
    assert_response :success

    # Read the expected content in binary mode.
    expected_content = pdf_file.open.read.force_encoding("ASCII-8BIT")

    # Force the response body to binary encoding.
    actual_content = @response.body.force_encoding("ASCII-8BIT")

    assert_equal expected_content, actual_content
  end
end
