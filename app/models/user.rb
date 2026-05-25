class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :expert_ratings, dependent: :destroy

  has_one_attached :avatar

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  ROLES = %w[expert admin].freeze

  before_validation :set_default_role, on: :create

  validates :role, presence: true, inclusion: { in: ROLES }

  def admin?
    role == "admin"
  end

  def expert?
    role == "expert"
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :username, presence: true,
            uniqueness: true,
            length: { maximum: 50 }

  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX },
            length: { maximum: 150 }

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

  def set_default_role
    self.role ||= "expert"
  end
end
