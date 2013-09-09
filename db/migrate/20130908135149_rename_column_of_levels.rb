class RenameColumnOfLevels < ActiveRecord::Migration
  def change
  	rename_column :levels, :tries, :order
  end
end
