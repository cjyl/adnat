class Organisation < ApplicationRecord
  has_many :organisation_users, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :hourly_rate, presence: true
end
