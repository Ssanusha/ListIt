# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120807175439) do

  create_table "doitusers", :force => true do |t|
    t.string "username",                :null => false
    t.string "password",  :limit => 32, :null => false
    t.string "name",                    :null => false
    t.string "email",                   :null => false
    t.string "randomPic"
  end

  create_table "friend_lists", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.string   "user_name",    :null => false
    t.string   "user_email",   :null => false
    t.string   "friend_name",  :null => false
    t.string   "friend_email", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "image_uploads", :force => true do |t|
    t.string   "username"
    t.string   "image_url"
    t.text     "image_desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "item_histories", :force => true do |t|
    t.integer  "item_id",       :null => false
    t.integer  "stores_id",     :null => false
    t.string   "item_name",     :null => false
    t.integer  "item_quantity", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "stores_name"
    t.integer  "user_id"
  end

  create_table "list_items", :force => true do |t|
    t.integer  "stores_id",   :null => false
    t.string   "name"
    t.integer  "quantity",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "stores_name"
    t.integer  "user_id"
  end

  create_table "shares", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "user_name",   :null => false
    t.string   "user_email",  :null => false
    t.string   "share_name"
    t.string   "share_email"
    t.integer  "stores_id",   :null => false
    t.string   "stores_name", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "share_id"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
    t.boolean  "is_bagged",  :default => false
    t.datetime "bagged_at"
  end

  add_index "stores", ["user_id"], :name => "fk_stores_users"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
