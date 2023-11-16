class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :information
      t.string :url
      t.string :image
      t.string :performers
      t.string :station_code, null: false

      t.timestamps
    end
    add_foreign_key :programs, :stations, column: :station_code, primary_key: :code
  end
end
