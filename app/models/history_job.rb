class HistoryJob < ApplicationRecord
  belongs_to :user
  belongs_to :jobs
end
