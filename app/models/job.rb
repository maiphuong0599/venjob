class Job < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :cities
  has_many :applies_jobs
  has_many :users, through: :applies_jobs
  belongs_to :company
end
