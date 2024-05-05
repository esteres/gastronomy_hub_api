class CreateRestaurantTags < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_tags do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :restaurant_tags, [:restaurant_id, :tag_id], unique: true
  end
end
