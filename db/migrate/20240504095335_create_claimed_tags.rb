class CreateClaimedTags < ActiveRecord::Migration[7.1]
  def change
    create_table :claimed_tags do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :claimed_tags, [:user_id, :tag_id], unique: true
  end
end
