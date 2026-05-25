require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:mobile_task)
  end

  test "index is available" do
    get tasks_path(locale: :ru)

    assert_response :success
  end

  test "can create task" do
    assert_difference("Task.count", 1) do
      post tasks_path(locale: :ru), params: {
        task: {
          user_id: users(:admin).id,
          theme_id: themes(:mobile).id,
          title: "New task",
          description: "Created in test"
        }
      }
    end

    assert_redirected_to task_path(Task.last, locale: :ru)
  end

  test "can update task" do
    patch task_path(@task, locale: :ru), params: {
      task: { title: "Updated task" }
    }

    assert_redirected_to task_path(@task, locale: :ru)
    assert_equal "Updated task", @task.reload.title
  end
end
