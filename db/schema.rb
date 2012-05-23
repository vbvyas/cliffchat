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

ActiveRecord::Schema.define(:version => 20120411062201) do

  create_table "affiliations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "affiliations", ["name"], :name => "index_affiliations_on_name"

  create_table "miniposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "affiliation_id"
  end

  add_index "miniposts", ["user_id", "created_at"], :name => "index_miniposts_on_user_id_and_created_at"

  create_table "responses", :force => true do |t|
    t.string   "content"
    t.integer  "minipost_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["minipost_id", "created_at"], :name => "index_responses_on_minipost_id_and_created_at"
  add_index "responses", ["user_id", "created_at"], :name => "index_responses_on_user_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "affiliation_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
