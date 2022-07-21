class User < ApplicationRecord
  has_many :organisations, through: :shifts, dependent: :destroy
  has_many :shifts, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 8 }
end
