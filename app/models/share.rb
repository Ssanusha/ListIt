class Share < ActiveRecord::Base
  attr_accessible :share_email, :share_name, :stores_id, :stores_name, :user_email, :user_id, :user_name, :share_id
  validates_presence_of :share_email, :share_name
  #validates_uniqueness_of :share_email
  
  
  def self.save_share_with_new_user(share,store,user,newuser)
    shn = self.new
    shn.user_id = user.id
    shn.user_name = user.name
    shn.user_email = user.email
    shn.share_id = newuser.id
    shn.share_name = share.share_name
    shn.share_email = share.share_email
    shn.stores_id = store.id
    shn.stores_name = store.name
    shn
  end
  
  def self.save_share(share,store,user,newuser)
    sh = self.new
    sh.user_id = user.id
    sh.user_name = user.name
    sh.user_email = user.email
    sh.share_id = newuser.id
    sh.share_name = share.share_name
    sh.share_email = share.share_email
    sh.stores_id = store.id
    sh.stores_name = store.name
    sh
  end

  
  def self.find_share_for_store(id)
    where("stores_id = ?", id).all
  end


  def self.find_shared_store_for_delete(user_id,store_id)
    store = self.new
    store = Share.find_by_sql("select shares.* from shares where user_id = '"+user_id.to_s+"' and stores_id = '"+store_id.to_s+"'")
  end
  
  
end
