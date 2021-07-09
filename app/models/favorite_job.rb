class FavoriteJob < ApplicationRecord
  belongs_to :user
  belongs_to :jobs
end
