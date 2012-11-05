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

ActiveRecord::Schema.define(:version => 20121104081042) do

  create_table "affiliations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "affiliations", ["name"], :name => "index_affiliations_on_name"

  create_table "followerships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followerships", ["topic_id"], :name => "index_followerships_on_topic_id"
  add_index "followerships", ["user_id", "topic_id"], :name => "index_followerships_on_user_id_and_topic_id", :unique => true
  add_index "followerships", ["user_id"], :name => "index_followerships_on_user_id"

  create_table "interests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followedpost_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interests", ["followedpost_id"], :name => "index_interests_on_followedpost_id"
  add_index "interests", ["user_id", "followedpost_id"], :name => "index_interests_on_user_id_and_followedpost_id", :unique => true
  add_index "interests", ["user_id"], :name => "index_interests_on_user_id"

  create_table "miniposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "affiliation_id"
  end

  add_index "miniposts", ["user_id", "created_at"], :name => "index_miniposts_on_user_id_and_created_at"

  create_table "miniposts_topics", :force => true do |t|
    t.integer  "minipost_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "miniposts_topics", ["minipost_id", "topic_id"], :name => "index_miniposts_topics_on_minipost_id_and_topic_id", :unique => true
  add_index "miniposts_topics", ["minipost_id"], :name => "index_miniposts_topics_on_minipost_id"
  add_index "miniposts_topics", ["topic_id"], :name => "index_miniposts_topics_on_topic_id"

  create_table "responses", :force => true do |t|
    t.string   "content"
    t.integer  "minipost_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["minipost_id", "created_at"], :name => "index_responses_on_minipost_id_and_created_at"
  add_index "responses", ["user_id", "created_at"], :name => "index_responses_on_user_id_and_created_at"

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["name"], :name => "index_topics_on_name"

  create_table "topics_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "topic_id"
  end

  add_index "topics_users", ["topic_id"], :name => "index_users_topics_on_topic_id"
  add_index "topics_users", ["user_id", "topic_id"], :name => "index_users_topics_on_user_id_and_topic_id", :unique => true
  add_index "topics_users", ["user_id"], :name => "index_users_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "affiliation_id"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "votedresponse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id", "votedresponse_id"], :name => "index_votes_on_user_id_and_response_id", :unique => true
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"
  add_index "votes", ["votedresponse_id"], :name => "index_votes_on_response_id"

end
