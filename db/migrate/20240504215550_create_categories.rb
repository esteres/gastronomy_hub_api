class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, limit: 100, null: false
      t.text :description
      t.string :icon_url
      t.integer :priority, null: false
      t.boolean :active, default: true
      t.boolean :is_public, default: true

      t.timestamps
    end

    add_index :categories, :name, unique: true
  end
end
