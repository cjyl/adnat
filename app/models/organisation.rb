class Organisation < ApplicationRecord
  has_many :shifts, dependent: :destroy
  has_many :users, through: :shifts, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :hourly_rate, presence: true
end
