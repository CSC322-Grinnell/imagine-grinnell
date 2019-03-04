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

ActiveRecord::Schema.define(version: 20190304205028) do

  create_table "gardens", force: :cascade do |t|
    t.string "garden_name"
    t.string "address"
    t.string "contact_name"
    t.string "phone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gardens_produces", id: false, force: :cascade do |t|
    t.integer "garden_id", null: false
    t.integer "produce_id", null: false
    t.index ["garden_id", "produce_id"], name: "index_gardens_produces_on_garden_id_and_produce_id"
    t.index ["produce_id", "garden_id"], name: "index_gardens_produces_on_produce_id_and_garden_id"
  end

  create_table "produces", force: :cascade do |t|
    t.string "name"
    t.string "prediction_date"
    t.integer "readiness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
