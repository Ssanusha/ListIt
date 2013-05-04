class ListItem < ActiveRecord::Base
  def self.find_list_items_for_store(id)
    #find(:all,  :order => "name")
    where("stores_id = ?", id).all
  end

  def self.remove_item(id)
    #li = where("stores_id = ?", id).all
    puts "trying to delete : #{id}"
    #destroy_all(:id => id)
    destroy(id)
  #it's destroy and destroy_all methods, like

  #user.destroy
  #User.find(15).destroy
  #User.destroy(15)
  #User.where(:age => 15).destroy_all
  #User.destroy_all(:age => 15)
  #Alternatively you can use delete and delete_all that won't trigger :before_destroy, :around_destroy, :after_destroy callbacks.
  end

  def self.get_item_count(id)
    @count = ListItem.count(:conditions => ['stores_id = ?', id ])
  end

  attr_accessible :name, :quantity, :stores_id,:stores_name,:user_id
  belongs_to :store
  validates_uniqueness_of :name, :scope => [:stores_id]

  def self.save_list_item(saveItem,store,user_id)
    li = self.new
    li.name= saveItem.name
    li.quantity= saveItem.quantity
    li.stores_id = store.id
    li.stores_name = store.name
    li.user_id = user_id
    li
  end

  def self.save_item_from_history(fromhis)
    new = self.new
    new.stores_id = fromhis.stores_id
    new.name = fromhis.item_name
    new.quantity = fromhis.item_quantity
    new.stores_name = fromhis.stores_name
    new.user_id = fromhis.user_id
    new
  end
end
