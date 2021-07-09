class User < ApplicationRecord
  has_many :apply_jobs
  has_many :favorite_jobs
  has_many :history_jobs
end
