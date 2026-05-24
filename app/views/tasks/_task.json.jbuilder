json.extract! task, :id, :user_id, :theme_id, :title, :description, :created_at, :updated_at
json.url task_url(task, format: :json)
