require "test_helper"

class Public::IssuesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_issues_show_url
    assert_response :success
  end
end
