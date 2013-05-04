class AddBaggedColumn < ActiveRecord::Migration
  def up
    add_column :stores, :is_bagged, :boolean, :default => false
    add_column :stores, :bagged_at, :datetime
  end

  def down
    remove_column :stores, :is_bagged
    remove_column :stores, :bagged_at
  end
end
