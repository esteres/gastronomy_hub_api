class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name, limit: 100

      t.timestamps
    end

    add_index :cities, :name, unique: true
  end
end
