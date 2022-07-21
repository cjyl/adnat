class AddUserToShift < ActiveRecord::Migration[7.0]
  def change
    add_reference :shifts, :user, null: false, foreign_key: true
  end
end
