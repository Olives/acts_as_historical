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

ActiveRecord::Schema.define(:version => 20110928180805) do

  create_table "dependent_models", :force => true do |t|
    t.string  "name"
    t.integer "watched_model_id"
    t.integer "second_watched_model_id"
    t.string  "status"
  end

  create_table "habtm_models", :force => true do |t|
    t.string "code"
  end

  create_table "habtm_models_watched_models", :id => false, :force => true do |t|
    t.integer "habtm_model_id"
    t.integer "watched_model_id"
  end

  create_table "histories", :force => true do |t|
    t.string   "history_editable_type"
    t.integer  "history_editable_id"
    t.datetime "created_at"
    t.string   "historical_type"
    t.integer  "historical_id"
    t.text     "before"
    t.text     "after"
    t.string   "item_type"
  end

  create_table "second_watched_models", :force => true do |t|
    t.string "name"
    t.string "status"
    t.string "watcher"
  end

  create_table "users", :force => true do |t|
    t.string "username"
  end

  create_table "watched_models", :force => true do |t|
    t.string "name"
    t.string "status"
    t.string "watcher"
  end

end
