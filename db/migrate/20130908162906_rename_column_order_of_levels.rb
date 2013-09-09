class RenameColumnOrderOfLevels < ActiveRecord::Migration
  def change
  	rename_column :levels, :order, :sort_order
  end
end
