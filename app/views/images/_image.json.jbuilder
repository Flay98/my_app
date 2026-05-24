json.extract! image, :id, :task_id, :file_name, :description, :created_at, :updated_at
json.url image_url(image, format: :json)
