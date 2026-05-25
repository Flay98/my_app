require "test_helper"

class WorkControllerTest < ActionDispatch::IntegrationTest
  test "guest is redirected from work area" do
    get work_path(locale: :ru)

    assert_redirected_to signin_path(locale: :ru)
  end

  test "signed in user can open work area" do
    sign_in_as users(:expert)

    get work_path(locale: :ru, theme_id: themes(:mobile).id)

    assert_response :success
  end
end
