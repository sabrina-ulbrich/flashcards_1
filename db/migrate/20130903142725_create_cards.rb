class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :question
      t.text :answer
      t.integer :cardset_id

      t.timestamps
    end
    add_index :cards, [:cardset_id]
  end
end
