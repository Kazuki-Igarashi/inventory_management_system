require "test_helper"

class Public::ReceivingControllerTest < ActionDispatch::IntegrationTest
  test "should get _stocks" do
    get public_receiving__stocks_url
    assert_response :success
  end

  test "should get index" do
    get public_receiving_index_url
    assert_response :success
  end

  test "should get show" do
    get public_receiving_show_url
    assert_response :success
  end

  test "should get search" do
    get public_receiving_search_url
    assert_response :success
  end
end
