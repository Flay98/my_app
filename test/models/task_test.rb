require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "task requires title" do
    task = Task.new(user: users(:admin), theme: themes(:mobile), description: "No title")

    assert_not task.valid?
    assert task.errors[:title].any?
  end

  test "task belongs to user and theme" do
    task = tasks(:mobile_task)

    assert_equal users(:expert), task.user
    assert_equal themes(:mobile), task.theme
  end
end
