require "test_helper"

class Public::ContractorsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_contractors_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_contractors_edit_url
    assert_response :success
  end

  test "should get quit" do
    get public_contractors_quit_url
    assert_response :success
  end

  test "should get out" do
    get public_contractors_out_url
    assert_response :success
  end
end
