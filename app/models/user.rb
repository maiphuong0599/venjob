class User < ApplicationRecord
  has_one_attached :cv
  has_many :apply_jobs, dependent: :destroy
  has_many :favorite_jobs, dependent: :destroy
  has_many :history_jobs, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 200 }
  validates :email, presence: true, length: { maximum: 200 }, format: { with: VALID_EMAIL_REGEX }
  validates :cv, presence: true, content_type: { in: 'application/pdf', message: 'must be a valid image format' },
                 size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
