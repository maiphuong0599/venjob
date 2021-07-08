class User < ApplicationRecord
  has_and_belongs_to_many :jobs
  has_many :applies_jobs
  has_many :jobs, through: :applies_jobs
end
