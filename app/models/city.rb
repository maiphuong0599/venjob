class City < ApplicationRecord
  belongs_to :regions
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :companies
end
