class Company < ApplicationRecord
  has_many :jobs
  has_and_belongs_to_many :cities
end
