class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :organisations, through: :organisation_users

  # validates :name, uniqueness: true, presence: true
  # validates :email, format: { with: /\A.*@.*\.com\z/ }, uniqueness: true, presence: true
  # validates :password, length: { minimum: 6 }, presence: true

  # validates


end
