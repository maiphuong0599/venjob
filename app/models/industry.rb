class Industry < ApplicationRecord
  has_and_belongs_to_many :jobs
  LATEST_INDUSTRY_NUMBER = 9
  scope :join_group, -> { joins(:jobs).group(:name).order('count_all DESC').count.take(LATEST_INDUSTRY_NUMBER) }
end
