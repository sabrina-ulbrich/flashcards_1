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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130914204837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.integer  "cardset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["cardset_id"], name: "index_cards_on_cardset_id", using: :btree

  create_table "cardsets", force: true do |t|
    t.string   "topic"
    t.text     "description"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.integer  "status"
    t.integer  "card_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order"
  end

  add_index "levels", ["card_id", "user_id"], name: "index_levels_on_card_id_and_user_id", unique: true, using: :btree

  create_table "selections", force: true do |t|
    t.integer  "user_id"
    t.integer  "cardset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "selections", ["user_id", "cardset_id"], name: "index_selections_on_user_id_and_cardset_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
