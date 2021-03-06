class User < ApplicationRecord
  has_one_attached :cv
  has_many :apply_jobs, dependent: :destroy
  has_many :favorite_jobs, dependent: :destroy
  has_many :history_jobs, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, length: { maximum: 200 }
  validates :email, length: { maximum: 200 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :cv, content_type: { in: 'application/pdf', message: 'must be a valid pdf format' },
                 size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
end