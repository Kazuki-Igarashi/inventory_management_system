require "test_helper"

class Public::InitialInvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_initial_invoices_show_url
    assert_response :success
  end
end
