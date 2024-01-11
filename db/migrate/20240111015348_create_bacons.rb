class CreateBacons < ActiveRecord::Migration[7.0]
  def change
    create_table :bacons do |t|
      t.string :to_encode
      t.string :to_decode
      t.string :key
      t.timestamps
    end
    add_reference :bacons, :user, foreign_key: true
  end
end
