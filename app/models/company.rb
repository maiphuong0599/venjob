class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_and_belongs_to_many :cities
end