class AddUserIdToCaesars < ActiveRecord::Migration[7.0]
  def change
    add_reference :caesars, :user, null: false, foreign_key: true
  end
end
