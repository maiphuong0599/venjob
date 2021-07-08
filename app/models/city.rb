class City < ApplicationRecord
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :companies
  has_many :regions
end
