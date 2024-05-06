class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name, limit: 100
      t.string :address, limit: 255
      t.string :zip_code, limit: 50
      t.references :restaurant, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end

    add_index :locations, [:name, :address], unique: true
  end
end
