class AddTriesToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :tries, :integer
  end
end
