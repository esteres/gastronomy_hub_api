class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :restaurant, null: false, foreign_key: true
      t.string :title, limit: 100, null: false
      t.text :content
      t.date :visit_date, null: false
      t.boolean :recommendation, null: false
      t.integer :rating, null: false
      t.integer :ambience_rating
      t.integer :service_rating
      t.integer :wait_time
      t.boolean :value_for_money

      t.timestamps
    end

    add_index :reviews, [:user_id, :restaurant_id], unique: true
  end
end
