class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, limit: 100, null: false
      t.text :description
      t.integer :priority, null: false
      t.boolean :active, default: true
      t.boolean :is_public, default: true

      t.timestamps
    end

    add_index :tags, :name, unique: true
  end
end
