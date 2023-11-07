require "test_helper"

class ShippingInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shipping_informations_index_url
    assert_response :success
  end
end
