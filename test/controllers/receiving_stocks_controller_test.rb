require "test_helper"

class ReceivingStocksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get receiving_stocks_index_url
    assert_response :success
  end

  test "should get show" do
    get receiving_stocks_show_url
    assert_response :success
  end

  test "should get search" do
    get receiving_stocks_search_url
    assert_response :success
  end
end
