class City < ApplicationRecord
  belongs_to :region
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :companies
end
