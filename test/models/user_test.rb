require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "fixture user is valid" do
    assert users(:expert).valid?
  end

  test "email is downcased before save" do
    user = User.new(
      username: "new_user",
      email: "New_User@Example.COM",
      first_name: "New",
      last_name: "User",
      password: "password",
      password_confirmation: "password"
    )

    assert user.save
    assert_equal "new_user@example.com", user.reload.email
  end

  test "role is expert by default" do
    user = User.create!(
      username: "default_role",
      email: "default@example.com",
      first_name: "Default",
      last_name: "Role",
      password: "password",
      password_confirmation: "password"
    )

    assert_equal "expert", user.role
    assert user.expert?
    assert_not user.admin?
  end

  test "email must be valid" do
    user = users(:expert).dup
    user.username = "invalid_email_user"
    user.email = "wrong-email"

    assert_not user.valid?
    assert user.errors[:email].any?
  end

  test "username must be unique" do
    duplicate = User.new(
      username: users(:expert).username,
      email: "another@example.com",
      first_name: "Another",
      last_name: "User",
      password: "password",
      password_confirmation: "password"
    )

    assert_not duplicate.valid?
    assert duplicate.errors[:username].any?
  end
end
