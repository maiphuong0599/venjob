class City < ApplicationRecord
  belongs_to :region
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :companies
  LATEST_CITY_NUMBER = 9
  scope :top_cities, -> { joins(:jobs).group(:name).order('count_all DESC').count.take(LATEST_CITY_NUMBER) }
  scope :city_vietnam, -> { joins(:jobs).group(:name).having('count_all >= ?', 1).where('region_id = 1').order('count_all DESC').count }
  scope :city_inter, -> { joins(:jobs).group(:name).having('count_all >= ?', 1).where('region_id = 2').order('count_all DESC').count }
end