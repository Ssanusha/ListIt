class AddStoreNameToHistory < ActiveRecord::Migration
  def change
    #add_column :item_histories, :stores_name, :string
    #execute <<-SQL
    #  ALTER TABLE item_histories ADD CONSTRAINT fk_item_history_stores_name FOREIGN KEY (stores_name) REFERENCES stores(name)
   # SQL
  end
end
