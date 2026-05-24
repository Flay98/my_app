json.extract! expert_rating, :id, :user_id, :image_id, :rating, :created_at, :updated_at
json.url expert_rating_url(expert_rating, format: :json)
