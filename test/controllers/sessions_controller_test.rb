require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "signin page is available" do
    get signin_path(locale: :ru)

    assert_response :success
  end

  test "user can sign in with valid credentials" do
    sign_in_as users(:expert)

    assert_redirected_to work_path(locale: :ru)
  end

  test "user cannot sign in with invalid password" do
    post signin_path(locale: :ru), params: {
      session: { email: users(:expert).email, password: "wrong" }
    }

    assert_response :unprocessable_entity
  end

  test "user can sign out" do
    sign_in_as users(:expert)

    delete signout_path(locale: :ru)

    assert_redirected_to root_path(locale: :ru)
  end
end
