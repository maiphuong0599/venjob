class User < ApplicationRecord
  has_one_attached :cv
  has_many :apply_jobs, dependent: :destroy
  has_many :favorite_jobs, dependent: :destroy
  has_many :history_jobs, dependent: :destroy
  VALID_FILE_UPLOAD = %w[application/msword application/pdf application/xls application/xlsx application/zip]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :name, length: { maximum: 200 }
  validates :email, length: { maximum: 200 }, uniqueness: true
  validates :cv, content_type: { in: VALID_FILE_UPLOAD, message: 'must be msword, pdf, xls, xlsx, zip format'},
                               size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
end