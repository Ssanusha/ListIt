class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :stores_id, :null =>false,:options => "CONSTRAINT fk_list_item_stores REFERENCES stores(id)"
      t.string :name
      t.integer :quantity, :null => false
      
      
      
      


      t.timestamps
    end
  end
end
