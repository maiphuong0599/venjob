class HistoryJob < ApplicationRecord
  belongs_to :user
  belongs_to :job
  LIMIT_HISTORY = 20
end
