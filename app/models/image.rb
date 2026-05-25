class Image < ApplicationRecord
  belongs_to :task

  has_many :expert_ratings, dependent: :destroy
  has_one :theme, through: :task

  validates :file_name, presence: true

  scope :by_theme, ->(theme_id) {
    joins(task: :theme).where(tasks: { theme_id: theme_id })
  }

  def average_rating
    expert_ratings.average(:rating)&.round(2)
  end

  def average_rating_text
    average_rating || "Нет оценок"
  end
end
