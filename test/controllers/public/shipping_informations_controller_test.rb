require "test_helper"

class Public::ShippingInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_shipping_informations_index_url
    assert_response :success
  end
end
