class AddUserIdToStore < ActiveRecord::Migration
  def change
    add_column :stores, :user_id, :integer
    execute <<-SQL
      ALTER TABLE stores ADD CONSTRAINT fk_stores_users FOREIGN KEY (user_id) REFERENCES users(id)
    SQL
  end
end
  