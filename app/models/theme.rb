class Theme < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :images, through: :tasks

  validates :name, presence: true
end