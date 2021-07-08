class Company < ApplicationRecord
  has_and_belongs_to_many :cities
  has_many :jobs
end
