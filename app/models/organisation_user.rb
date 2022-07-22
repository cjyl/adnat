class OrganisationUser < ApplicationRecord
  belongs_to :user
  belongs_to :organisation
  has_many :shifts, dependent: :destroy
end
