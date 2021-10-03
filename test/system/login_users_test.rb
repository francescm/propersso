require "application_system_test_case"

class LoginUsersTest < ApplicationSystemTestCase
  test "visiting the welcome page" do
    visit main_welcome_url

    SsoEnvTranslator.stub :exec, {uid: "jdoe", cn: "John Doe"} do
      click_on "Login with Shibboleth"
      assert_text "Welcome John Doe"

    end


  end

end
