class CreateClaimedCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :claimed_categories do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :claimed_categories, [:user_id, :category_id], unique: true
  end
end
