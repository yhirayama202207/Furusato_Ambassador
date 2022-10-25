require "test_helper"

class Admin::JapanAreasControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_japan_areas_edit_url
    assert_response :success
  end

  test "should get index" do
    get admin_japan_areas_index_url
    assert_response :success
  end
end
