class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.string :delete_password, null: false
      t.bigint :program_id, null: false

      t.timestamps
    end
    add_foreign_key :messages, :programs, column: :program_id, primary_key: :id
  end
end
