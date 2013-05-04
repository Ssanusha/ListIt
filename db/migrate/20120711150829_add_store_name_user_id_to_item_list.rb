class AddStoreNameUserIdToItemList < ActiveRecord::Migration
  def change
    add_column :list_items, :stores_name, :string
    add_column :list_items, :user_id, :integer
  end
end
