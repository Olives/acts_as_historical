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

ActiveRecord::Schema.define(:version => 20110921183926) do

  create_table "action_histories", :force => true do |t|
    t.integer  "history_editor_id"
    t.string   "history_editor_type"
    t.datetime "created_at"
    t.string   "history_recordable_type"
    t.integer  "history_recordable_id"
    t.string   "history_dependable_type"
    t.integer  "history_dependable_id"
    t.text     "changed_fields"
  end

  create_table "dependent_models", :force => true do |t|
    t.string  "name"
    t.integer "watched_model_id"
    t.integer "second_watched_model_id"
    t.string  "status"
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