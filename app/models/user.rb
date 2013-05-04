require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessible :name, :hashed_password, :username, :salt, :email, :password, :password_confirmation, :current_password, :avatar
  validates_presence_of :email , :name
  validates_uniqueness_of  :email
  
  has_attached_file :avatar, :styles => { :small => "150x150>", :thumb => "40x40>" },
                  :url  => "/assets/users/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

  validates :password, :presence     => true,
                                       :if => :validate_password?,
                                       :confirmation => true,
                                       :length       => { :within => 6..40 }

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  attr_accessor :password_confirmation
  validates_confirmation_of :password
  validate :password_non_blank
  def self.find_user_with_email(share_email)
    findUser = self.new
    #findUser = User.find_by_sql("select * from users where email='"+share_email.to_s+"'")
    findUser = where("email = ?", share_email.to_s)
  end

  def self.find_user(id, password)
    #findUser = self.new
    #findUser = User.find_by_sql("select * from users where email='"+share_email.to_s+"'")
    where("id = ?, hashed_password = ?", id, password).all
  end

  def self.reset_password(id, password)
    update_all({:hashed_password=>password}, ['id = (?)', User.select('DISTINCT(id)').where(:id => id)])
  #update_by_sql("update users set hashed_password='"+password.to_s+"' where id="+id.to_s)
  #update(id,{ :hashed_password => password })
  end

  def self.save_new_user(password,share)
    us = self.new
    us.username = share.share_email
    us.email = share.share_email
    us.password = password
    us.name = share.share_name
    us
  end

  def password
    @password
  end

  def password=(pwd)
    puts "PUTTING #{pwd}"
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def current_password
    @current_password
  end

  def current_password=(pwd)
    @current_password = pwd
  end

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def validate_password?
    if new_record?
    return true
    else
      if password.to_s.empty?
      return false
      else
      return true
      end
    end
  end

  private

  def password_non_blank
    errors.add(:password, "Missing password" ) if hashed_password.blank?
  end

  def self.encrypted_password(password, salt)
    return if password.to_s.empty?
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
