class CreateRestaurantCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_categories do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :restaurant_categories, [:restaurant_id, :category_id], unique: true
  end
end
