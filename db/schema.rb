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

ActiveRecord::Schema.define(version: 20190225095746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth1s", force: :cascade do |t|
    t.string   "password_digest"
    t.integer  "user1_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "otp"
    t.index ["user1_id"], name: "index_auth1s_on_user1_id", using: :btree
  end

  create_table "session1s", force: :cascade do |t|
    t.string   "token"
    t.integer  "auth1_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth1_id"], name: "index_session1s_on_auth1_id", using: :btree
  end

  create_table "socialauths", force: :cascade do |t|
    t.string   "device_type"
    t.string   "device_id"
    t.integer  "user1_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user1_id"], name: "index_socialauths_on_user1_id", using: :btree
  end

  create_table "user1s", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "email"
    t.string   "contact_no"
    t.string   "gender"
    t.date     "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.integer  "contact"
    t.string   "gender"
    t.date     "dob"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "auth1s", "user1s"
  add_foreign_key "session1s", "auth1s"
  add_foreign_key "socialauths", "user1s"
end
