class User < ApplicationRecord
  has_many :apply_jobs, dependent: :destroy
  has_many :favorite_jobs, dependent: :destroy
  has_many :history_jobs, dependent: :destroy
end
