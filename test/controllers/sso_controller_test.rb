require "test_helper"

class SsoControllerTest < ActionDispatch::IntegrationTest
  test "should get auth" do
    get sso_auth_url
    assert_response :success
  end
end
