class AddOrganisationUserToShifts < ActiveRecord::Migration[7.0]
  def change
    add_reference :shifts, :organisation_user, null: false, foreign_key: true
  end
end
