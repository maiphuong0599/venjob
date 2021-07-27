class City < ApplicationRecord
  belongs_to :region
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :companies
  LATEST_CITY_NUMBER = 9
  scope :join_group, -> { joins(:jobs).group(:name).order('count_all DESC').count.take(LATEST_CITY_NUMBER) }
end

