class UsersController < ApplicationController
  has_many :organisations, through: :organisation_users

  validates :name, uniqueness: true, presence: true
  validates :email, format: { with: /\A.*@.*\.com\z/ }, uniqueness: true, presence: true
  validates :password, length: { minimum: 6 }, presence: true
end
