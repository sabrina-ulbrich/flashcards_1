class AddIndexToSelections < ActiveRecord::Migration
  def change
  	add_index :selections, [:user_id, :cardset_id], unique: true
  end
end
