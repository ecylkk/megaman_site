require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get select" do
    get pages_select_url
    assert_response :success
  end

  test "should get stage" do
    get pages_stage_url
    assert_response :success
  end
end
