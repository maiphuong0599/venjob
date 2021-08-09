class ApplyJob < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_one_attached :cv
  validates :name, presence: true #size: { less_than_or_equal_to: 400.bytes, message: 'is not given between size' }
  validates :email, presence: true
  validates :cv, attached: true #, content_type: { in: 'application/pdf', message: 'must be a valid cv format' }
  #content_type: { in: %w[application/msword application/pdf]
end
