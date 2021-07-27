class Job < ApplicationRecord
  belongs_to :company
  has_many :apply_jobs
  has_many :favorite_jobs
  has_many :history_jobs
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :cities
  LATEST_JOB_NUMBER = 5
  scope :join_order, -> { joins(:cities).order('created_at DESC').limit(LATEST_JOB_NUMBER) }
end
