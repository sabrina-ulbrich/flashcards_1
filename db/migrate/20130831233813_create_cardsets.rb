class CreateCardsets < ActiveRecord::Migration
  def change
    create_table :cardsets do |t|
      t.string :topic
      t.text :description
      t.integer :user_id

      t.timestamps
    end
    add_index :cardsets, [:user_id]
  end
end
