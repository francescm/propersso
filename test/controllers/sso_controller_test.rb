require "test_helper"

class SsoControllerTest < ActionDispatch::IntegrationTest
  test "should get auth" do
    get sso_auth_url, env: {
        uid: "id001",
        cn: "name surname",
        "Shib-Session-ID" => "abc"
    }
    assert_redirected_to main_welcome_url
  end
end
