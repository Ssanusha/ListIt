class AddUserIdToItemHistories < ActiveRecord::Migration
  def change
    add_column :item_histories, :user_id, :integer
  end
end
