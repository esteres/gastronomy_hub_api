class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name, limit: 100
      t.text :description
      t.integer :contact_information_type
      t.string :contact_information, limit: 100

      t.timestamps
    end
    add_index :restaurants, :name, unique: true
  end
end
