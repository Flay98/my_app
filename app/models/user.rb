class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :expert_ratings, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end