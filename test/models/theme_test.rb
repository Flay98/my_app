require "test_helper"

class ThemeTest < ActiveSupport::TestCase
  test "theme requires name" do
    theme = Theme.new(description: "No name")

    assert_not theme.valid?
    assert theme.errors[:name].any?
  end

  test "theme has related tasks and images" do
    theme = themes(:mobile)

    assert_includes theme.tasks, tasks(:mobile_task)
    assert_includes theme.images, images(:mobile_first)
  end
end
