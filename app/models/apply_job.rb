class ApplyJob < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_one_attached :cv
  validates :name, presence: true, length: { maximum: 200 }
  VALID_FILE_UPLOAD = %w[application/msword application/pdf application/xls application/xlsx application/zip].freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :cv, presence: true, content_type: { in: VALID_FILE_UPLOAD, message: 'must be a valid pdf format' },
                 size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
end
