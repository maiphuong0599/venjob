class Job < ApplicationRecord
  belongs_to :companies
  has_many :apply_jobs
  has_many :favorite_jobs
  has_many :history_jobs
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :cities
end
