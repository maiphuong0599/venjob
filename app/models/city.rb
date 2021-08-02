class City < ApplicationRecord
  belongs_to :region
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :companies
  LATEST_CITY_NUMBER = 9
  REGION_VN_ID = 1
  REGION_INTERNATIONAL_ID = 2
  scope :top_cities, -> { joins(:jobs).group(:name).order('count_all DESC').count.take(LATEST_CITY_NUMBER) }
  scope :cities_by_region, ->(value) { joins(:jobs).group(:name).having('count_all >= ?', 1).where('region_id = ?', value).order('count_all DESC').count }
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]
  def normalize_friendly_id(string)
    string.to_s.to_slug.normalize(transliterations: :vietnamese).to_s
  end
end