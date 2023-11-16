class CreateAvailableStations < ActiveRecord::Migration[6.1]
  def change
    create_table :available_stations do |t|
      t.integer :prefecture_code, null: false
      t.string :station_code, null: false

      t.timestamps
    end
    add_foreign_key :available_stations, :prefectures, column: :prefecture_code, primary_key: :code
    add_foreign_key :available_stations, :stations, column: :station_code, primary_key: :code
  end
end
