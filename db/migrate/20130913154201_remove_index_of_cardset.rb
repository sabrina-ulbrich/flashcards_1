class RemoveIndexOfCardset < ActiveRecord::Migration
  def change
  	remove_index :cardsets, :user_id
  end
end
