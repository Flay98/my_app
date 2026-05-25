require "test_helper"

class ThemesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @theme = themes(:mobile)
  end

  test "index is available" do
    get themes_path(locale: :ru)

    assert_response :success
  end

  test "can create theme" do
    assert_difference("Theme.count", 1) do
      post themes_path(locale: :ru), params: {
        theme: { name: "New Theme", description: "Created in test" }
      }
    end

    assert_redirected_to theme_path(Theme.last, locale: :ru)
  end

  test "can update theme" do
    patch theme_path(@theme, locale: :ru), params: {
      theme: { name: "Updated Theme" }
    }

    assert_redirected_to theme_path(@theme, locale: :ru)
    assert_equal "Updated Theme", @theme.reload.name
  end
end
