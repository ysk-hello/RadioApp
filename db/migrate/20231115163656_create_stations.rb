class CreateStations < ActiveRecord::Migration[6.1]
  def change
    create_table :stations, id: false do |t|
      t.integer :code, null: false, primary_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
