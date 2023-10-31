require "test_helper"

class Admin::ContractorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_contractors_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_contractors_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_contractors_edit_url
    assert_response :success
  end
end
