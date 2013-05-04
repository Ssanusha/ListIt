class ImageUpload < ActiveRecord::Base
  attr_accessible :image_desc, :image_url, :username
end
