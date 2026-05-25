require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:expert)
  end

  test "signup page is available" do
    get signup_path(locale: :ru)

    assert_response :success
  end

  test "can create user" do
    assert_difference("User.count", 1) do
      post users_path(locale: :ru), params: {
        user: {
          username: "created_user",
          email: "created@example.com",
          first_name: "Created",
          last_name: "User",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to work_path(locale: :ru)
  end

  test "profile page is available" do
    get user_path(@user, locale: :ru)

    assert_response :success
  end

  test "can update user" do
    patch user_path(@user, locale: :ru), params: {
      user: { first_name: "Updated" }
    }

    assert_redirected_to user_path(@user, locale: :ru)
    assert_equal "Updated", @user.reload.first_name
  end
end
