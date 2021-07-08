class Job < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :applies_jobs
  has_many :users, through: :applies_jobs
end
