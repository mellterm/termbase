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

ActiveRecord::Schema.define(:version => 20120604062541) do

  create_table "associations", :force => true do |t|
    t.integer  "associator_id"
    t.integer  "associated_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "associations", ["associated_id"], :name => "index_associations_on_associated_id"
  add_index "associations", ["associator_id", "associated_id"], :name => "index_associations_on_associator_id_and_associated_id", :unique => true
  add_index "associations", ["associator_id"], :name => "index_associations_on_associator_id"

  create_table "authorities", :force => true do |t|
    t.integer  "authoritable_id"
    t.string   "authoritable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.string   "group_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "name"
    t.string   "access_code"
    t.integer  "owner_id"
    t.integer  "owner_profile_id"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "locality"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
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

  create_table "profiles", :force => true do |t|
    t.string   "real_name",          :null => false
    t.date     "birthday"
    t.integer  "native_language_id", :null => false
    t.text     "bio"
    t.integer  "badge_id",           :null => false
    t.integer  "location_id"
    t.integer  "user_id",            :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "profiles", ["user_id", "badge_id"], :name => "user_badge_unique_index", :unique => true

  create_table "ratings", :force => true do |t|
    t.integer  "score"
    t.integer  "ratable_id"
    t.string   "ratable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "translation_versions", :force => true do |t|
    t.integer  "translation_id"
    t.integer  "version"
    t.integer  "source_language_id"
    t.string   "source_content"
    t.integer  "target_language_id"
    t.string   "target_content"
    t.integer  "created_by_id"
    t.integer  "group_id"
    t.text     "metadata"
    t.string   "ilk",                :default => "Term"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "versioned_type"
  end

  add_index "translation_versions", ["translation_id"], :name => "index_translation_versions_on_translation_id"

  create_table "translations", :force => true do |t|
    t.integer  "source_language_id"
    t.string   "source_content"
    t.integer  "target_language_id"
    t.string   "target_content"
    t.integer  "version"
    t.string   "type"
    t.integer  "created_by_id"
    t.integer  "group_id"
    t.text     "metadata"
    t.string   "ilk",                :default => "Term"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "translations", ["source_content", "target_content", "created_by_id", "group_id"], :name => "unique_trans_user_and_group", :unique => true
  add_index "translations", ["source_content"], :name => "index_translations_on_source_content"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "subscribed"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "location_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
