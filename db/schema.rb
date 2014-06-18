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

ActiveRecord::Schema.define(version: 20140617115110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.integer  "type_id",      default: 0
    t.integer  "user_id"
    t.string   "name",                     null: false
    t.datetime "date"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
    t.integer  "ticket_price"
    t.string   "fb_id_number"
    t.string   "url_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "facebook_places", force: true do |t|
    t.string   "place_id",   null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types_users", id: false, force: true do |t|
    t.integer "type_id"
    t.integer "user_id"
  end

  add_index "types_users", ["user_id", "type_id"], name: "index_types_users_on_user_id_and_type_id", unique: true, using: :btree
  add_index "types_users", ["user_id"], name: "index_types_users_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",         limit: 25
    t.string   "name",             limit: 100
    t.integer  "ranking",                      default: 0
    t.text     "profile_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "admin",                        default: false
  end

end
