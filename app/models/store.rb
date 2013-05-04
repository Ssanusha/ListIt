class Store < ActiveRecord::Base
   attr_accessible :name, :user_id
   # validates the values are not blank
  validates_presence_of :name, :user_id
  #http://ar.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html#M000086
  validates_uniqueness_of :name, :scope => [:user_id]
  has_many :list_items
 
  
  def self.find_store_for_user(user_id)
    
    store = self.new
    #store = Store.find_by_sql("select stores.* from stores where user_id = '"+user_id.to_s+"' UNION (select stores.* from stores where id in (select stores_id from shares where share_id = '"+user_id.to_s+"'))");
    store = Store.find_by_sql("select stores.* from stores where user_id = '"+user_id.to_s+"'  UNION  select s1.* from stores s1  inner join shares s2 on s2.share_id = '"+user_id.to_s+"' and s1.id = s2.stores_id")
    
  end
  
  
  
  
  def self.find_store(id)
    where("id = ?", id).all
  end
  
  def self.find_if_my_store(user_id,store_id)
    store = self.new
    store = Store.find_by_sql("select stores.* from stores where user_id = '"+user_id.to_s+"' and id = '"+store_id.to_s+"'")
  end
  
  def self.find_my_stores(user_id)
    store = self.new
    store = Store.find_by_sql("select stores.* from stores where user_id = '"+user_id.to_s+"'")
  end
  
  def self.find_my_share_stores(user_id)
    store = self.new
    store = Store.find_by_sql("select s1.* from stores s1  inner join shares s2 on s2.share_id = '"+user_id.to_s+"' and s1.id = s2.stores_id")
  end
  
  def self.insert_new_store(id,name,user_id)
    newstore = self.new
    newstore.name = name
    newstore.id = id
    newstore.user_id = user_id
    newstore
  end
  
end
