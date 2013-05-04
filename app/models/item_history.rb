
class ItemHistory < ActiveRecord::Base
  attr_accessible :item_id, :item_name, :item_quantity, :stores_id,:stores_name, :user_id
  validates_uniqueness_of :item_id, :scope => [:stores_id]
  has_many :list_items
  belongs_to :store
  DAYS = ["For Today", 0], ["Past 1 Day", 1], ["Past 2 Days", 2], ["Past 3 Days", 3], ["Past 4 Days", 4], ["Past 5 Days", 5], ["Past 6 Days", 6], ["Past 7 Days", 7], ["Past 8 Days", 8], ["Past 9 Days", 9], ["Past 10 Days", 10], ["Past 11 Days", 11], ["Past 12 Days", 12], ["Past 13 Days", 13], ["Past 14 Days", 14], ["Past 15 Days", 15], ["Past 16 Days", 16],
        ["Past 17 Days", 17], ["Past 18 Days", 18], ["Past 19 Days", 19], ["Past 20 Days", 20], ["Past 21 Days", 21], ["Past 22 Days", 22], ["Past 23 Days", 23], ["Past 24 Days", 24], ["Past 25 Days", 25], ["Past 26 Days", 26], ["Past 27 Days", 27], ["Past 28 Days", 28], ["Past 29 Days", 29], ["Past 30 Days", 30], ["Past 31 Days", 31]
  
  def save_item_to_history(listItem)
    
    hi = ItemHistory.new
    hi.item_id= listItem.id
    hi.item_name=listItem.name
    hi.item_quantity=listItem.quantity
    hi.stores_id=listItem.stores_id
    hi.stores_name = listItem.stores_name
    hi.user_id = listItem.user_id
    hi    
  end
  
  def self.show_item_from_history(user_id,day)
    #self.all(:include => :stores, :conditions => ["stores.user_id = ?",user_id] )
    sh = ItemHistory.find_by_sql("select * from item_histories where item_histories.user_id= '"+user_id.to_s+"' and datediff(date(now()), date(updated_at)) <= '"+day.to_s+"' order by item_histories.stores_id desc")
  end
  
end
