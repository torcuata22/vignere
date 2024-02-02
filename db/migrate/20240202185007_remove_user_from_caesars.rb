class RemoveUserFromCaesars < ActiveRecord::Migration[7.0]
  def change
    remove_reference :caesars, :user, null: false, foreign_key: true
  end
end
