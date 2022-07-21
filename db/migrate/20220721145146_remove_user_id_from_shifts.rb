class RemoveUserIdFromShifts < ActiveRecord::Migration[7.0]
  def change
    remove_column :shifts, :user_id
  end
end
