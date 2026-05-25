class MainController < ApplicationController
  def index
    @images_count = Image.count
    @users_count = User.count
    @ratings_count = ExpertRating.count
    @system_average_rating = ExpertRating.average(:rating)&.round(2)

    @top_images = Image
                    .left_joins(:expert_ratings)
                    .includes(task: :theme)
                    .select("images.*, AVG(expert_ratings.rating) AS average_rating_value")
                    .group("images.id")
                    .having("COUNT(expert_ratings.id) > 0")
                    .order(Arel.sql("AVG(expert_ratings.rating) DESC"))
                    .limit(3)
  end

  def help
  end

  def contacts
  end

  def about
  end
end
