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

ActiveRecord::Schema.define(version: 2024_09_26_164150) do

  create_table "aircrafts", force: :cascade do |t|
    t.string "acft"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "haul_id"
  end

  create_table "airline_codes", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "flight_id", null: false
    t.integer "customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.string "status", default: "active"
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
  end

  create_table "cabins", force: :cascade do |t|
    t.string "cbn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_customers_on_deleted_at"
  end

  create_table "flights", force: :cascade do |t|
    t.integer "aircraft_id"
    t.integer "cabin_id"
    t.integer "registration_id"
    t.integer "seat_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reg"
    t.integer "haul_id"
    t.integer "departure_station_id"
    t.integer "arrival_station_id"
    t.string "airline_code"
    t.integer "flight_number"
    t.integer "airline_code_id"
    t.date "departure_date"
    t.date "arrival_date"
    t.string "departure_place_name"
    t.string "departure_country_name"
    t.string "arrival_place_name"
    t.string "arrival_country_name"
    t.boolean "is_return_flight", default: false
    t.index ["aircraft_id"], name: "index_flights_on_aircraft_id"
    t.index ["arrival_station_id"], name: "index_flights_on_arrival_station_id"
    t.index ["cabin_id"], name: "index_flights_on_cabin_id"
    t.index ["departure_station_id"], name: "index_flights_on_departure_station_id"
    t.index ["haul_id"], name: "index_flights_on_haul_id"
    t.index ["registration_id"], name: "index_flights_on_registration_id"
    t.index ["seat_id"], name: "index_flights_on_seat_id"
  end

  create_table "geocodings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.integer "haul_id"
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
    t.string "place_name"
    t.string "country_name"
    t.float "latitude"
    t.float "longitude"
    t.integer "haul_id"
    t.index ["haul_id"], name: "index_stations_on_haul_id"
  end

  add_foreign_key "bookings", "customers"
  add_foreign_key "bookings", "flights"
  add_foreign_key "flights", "aircrafts"
  add_foreign_key "flights", "cabins"
  add_foreign_key "flights", "hauls"
  add_foreign_key "flights", "registrations"
  add_foreign_key "flights", "seats"
  add_foreign_key "flights", "stations", column: "arrival_station_id"
  add_foreign_key "flights", "stations", column: "departure_station_id"
end
