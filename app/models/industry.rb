class Industry < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]
  has_and_belongs_to_many :jobs
  LATEST_INDUSTRY_NUMBER = 9

  scope :top_industries, -> { group(:name, :slug).order('count_all DESC').count.take(LATEST_INDUSTRY_NUMBER) }
  scope :industry_list, -> { group(:name, :slug).having('count_all >= ?', 1).order('count_all DESC').count }

  def normalize_friendly_id(string)
    string.to_s.to_slug.normalize(transliterations: :vietnamese).to_s
  end
end