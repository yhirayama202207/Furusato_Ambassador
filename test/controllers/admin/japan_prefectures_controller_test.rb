require "test_helper"

class Admin::JapanPrefecturesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_japan_prefectures_edit_url
    assert_response :success
  end

  test "should get index" do
    get admin_japan_prefectures_index_url
    assert_response :success
  end
end
