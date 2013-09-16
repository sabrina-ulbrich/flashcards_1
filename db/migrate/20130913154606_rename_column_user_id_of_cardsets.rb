class RenameColumnUserIdOfCardsets < ActiveRecord::Migration
  def change
  	rename_column :cardsets, :user_id, :author_id
  end
end
