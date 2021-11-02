class Admin < ApplicationRecord
  CSV_ATTRIBUTES = %w[id name email created_at].freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
