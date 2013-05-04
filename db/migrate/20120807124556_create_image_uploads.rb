class CreateImageUploads < ActiveRecord::Migration
  def change
    create_table :image_uploads do |t|
      t.string :username
      t.string :image_url
      t.text :image_desc

      t.timestamps
    end
  end
end
