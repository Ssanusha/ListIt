class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :users, :password, :hashed_password

  end

  def down
  end
end
