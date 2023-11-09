require "test_helper"

class Public::CompanysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_companys_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_companys_edit_url
    assert_response :success
  end

  test "should get _form" do
    get public_companys__form_url
    assert_response :success
  end

  test "should get _error" do
    get public_companys__error_url
    assert_response :success
  end
end
