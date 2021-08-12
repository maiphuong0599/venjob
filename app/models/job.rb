class Job < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]
  belongs_to :company
  has_many :apply_jobs, dependent: :destroy
  has_many :favorite_jobs, dependent: :destroy
  has_many :history_jobs, dependent: :destroy
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :cities
  LATEST_JOB_NUMBER = 5
  scope :latest_jobs, -> { includes(:cities, :company).order('created_at DESC') }

  def normalize_friendly_id(string)
    string.to_s.to_slug.normalize(transliterations: :vietnamese).to_s
  end
end