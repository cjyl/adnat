class RemoveOrganisationIdFromShifts < ActiveRecord::Migration[7.0]
  def change
    remove_column :shifts, :organisation_id
  end
end
