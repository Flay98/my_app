require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "root page is available" do
    get root_path(locale: :ru)

    assert_response :success
    assert_select "body"
  end

  test "static pages are available" do
    get help_path(locale: :ru)
    assert_response :success

    get contacts_path(locale: :ru)
    assert_response :success

    get about_path(locale: :ru)
    assert_response :success
  end
end
