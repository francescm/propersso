require "test_helper"

class SloControllerTest < ActionDispatch::IntegrationTest
  test "should get notify" do
    get slo_notify_url
    assert_response :success
  end
end
