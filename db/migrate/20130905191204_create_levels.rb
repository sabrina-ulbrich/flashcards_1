class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :status
      t.integer :card_id
      t.integer :user_id

      t.timestamps
    end

    add_index :levels, [:card_id, :user_id], unique: true
  end
end
