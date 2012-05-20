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

ActiveRecord::Schema.define(:version => 20120520072706) do

  create_table "authorities", :force => true do |t|
    t.integer  "authoritable_id"
    t.string   "authoritable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "name"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "contexts", :force => true do |t|
    t.integer  "translation_id"
    t.integer  "domain_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_on"
    t.datetime "expires_on"
    t.boolean  "expired"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "score"
    t.integer  "ratable_id"
    t.string   "ratable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "translations", :force => true do |t|
    t.integer  "source_language_id"
    t.string   "source_content"
    t.integer  "target_language_id"
    t.string   "target_content"
    t.integer  "version"
    t.string   "type"
    t.integer  "authority_id"
    t.text     "metadata"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "translations", ["source_content"], :name => "index_translations_on_source_content"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "subscribed"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
