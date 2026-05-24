class Task < ApplicationRecord
  belongs_to :user
  belongs_to :theme

  has_many :images, dependent: :destroy

  validates :title, presence: true
end
