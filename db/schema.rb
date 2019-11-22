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

ActiveRecord::Schema.define(version: 20191121214128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crops", force: :cascade do |t|
    t.integer "produce"
    t.integer "garden_id"
    t.string "planted_at"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "garden_produces", force: :cascade do |t|
    t.string "garden_id"
    t.string "produce_id"
    t.string "available_at"
    t.integer "readiness"
    t.string "planted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gardens", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "lat"
    t.float "long"
    t.string "contact_name_1"
    t.string "contact_number_1"
    t.string "email_1"
    t.string "contact_name_2"
    t.string "contact_number_2"
    t.string "email_2"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produces", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.date "start_date"
    t.date "end_date"
    t.string "image"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_volunteers_on_email", unique: true
  end

end
