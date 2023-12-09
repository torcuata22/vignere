class CreatePlayfairs < ActiveRecord::Migration[7.0]
  def change
    create_table :playfairs do |t|
      t.string :to_encode
      t.string :to_decode
      t.string :key
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
