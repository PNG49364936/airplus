# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_12_12_091411) do

  create_table "aircrafts", force: :cascade do |t|
    t.string "acft"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "haul"
    t.integer "haul_id"
  end

  create_table "cabins", force: :cascade do |t|
    t.string "cbn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flight_numbers", force: :cascade do |t|
    t.string "code"
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flights", force: :cascade do |t|
    t.integer "aircraft_id"
    t.integer "cabin_id"
    t.integer "registration_id"
    t.integer "seat_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reg"
    t.string "haul"
    t.integer "haul_id"
    t.integer "departure_station_id"
    t.integer "arrival_station_id"
    t.index ["aircraft_id"], name: "index_flights_on_aircraft_id"
    t.index ["arrival_station_id"], name: "index_flights_on_arrival_station_id"
    t.index ["cabin_id"], name: "index_flights_on_cabin_id"
    t.index ["departure_station_id"], name: "index_flights_on_departure_station_id"
    t.index ["haul_id"], name: "index_flights_on_haul_id"
    t.index ["registration_id"], name: "index_flights_on_registration_id"
    t.index ["seat_id"], name: "index_flights_on_seat_id"
  end

  create_table "hauls", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.string "reg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seats", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "haul"
  end

  add_foreign_key "flights", "aircrafts"
  add_foreign_key "flights", "cabins"
  add_foreign_key "flights", "hauls"
  add_foreign_key "flights", "registrations"
  add_foreign_key "flights", "seats"
  add_foreign_key "flights", "stations", column: "arrival_station_id"
  add_foreign_key "flights", "stations", column: "departure_station_id"
end
