class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :user_id, :null =>false,:options => "CONSTRAINT fk_share_user_id REFERENCES users(id)"
      t.string :user_name, :null =>false,:options => "CONSTRAINT fk_share_user_name REFERENCES users(username)"
      t.string :user_email, :null =>false,:options => "CONSTRAINT fk_share_user_email REFERENCES users(email)"
      t.string :share_name
      t.string :share_email
      t.integer :stores_id, :null =>false,:options => "CONSTRAINT fk_share_stores_id REFERENCES stores(id)"
      t.string :stores_name, :null =>false,:options => "CONSTRAINT fk_share_stores_name REFERENCES stores(name)"

      t.timestamps
    end
  end
end
