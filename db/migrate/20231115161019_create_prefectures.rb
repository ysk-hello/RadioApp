class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures, id: false do |t|
      t.string :code, null: false, primary_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
