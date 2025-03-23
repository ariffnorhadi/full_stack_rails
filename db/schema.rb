# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_23_051533) do
  create_table "aircrafts", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "model", null: false
    t.string "registration_number", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_aircrafts_on_company_id"
  end

  create_table "airports", force: :cascade do |t|
    t.string "iata_code", null: false
    t.string "icao_code", null: false
    t.string "name", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string "name", null: false
    t.string "swift_code", null: false
    t.string "country", null: false
    t.string "branch_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "flight_id", null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "business_registration_no", null: false
    t.string "profile_name", null: false
    t.string "country", null: false
    t.text "address", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.string "website"
    t.string "tax_identification_number"
    t.string "bank_account_number", null: false
    t.integer "bank_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_companies_on_bank_id"
  end

  create_table "flights", force: :cascade do |t|
    t.integer "aircraft_id", null: false
    t.string "flight_number", null: false
    t.integer "departure_airport_id", null: false
    t.integer "arrival_airport_id", null: false
    t.datetime "departure_time", null: false
    t.datetime "arrival_time", null: false
    t.decimal "ticket_price", precision: 10, scale: 2, null: false
    t.integer "available_seats"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_flights_on_aircraft_id"
    t.index ["arrival_airport_id"], name: "index_flights_on_arrival_airport_id"
    t.index ["departure_airport_id"], name: "index_flights_on_departure_airport_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.integer "booking_id", null: false
    t.string "full_name", null: false
    t.string "passport_number", null: false
    t.integer "seat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_passengers_on_booking_id"
    t.index ["seat_id"], name: "index_passengers_on_seat_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "aircraft_id", null: false
    t.string "seat_number", null: false
    t.integer "seat_class", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_seats_on_aircraft_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "aircrafts", "companies"
  add_foreign_key "bookings", "flights"
  add_foreign_key "bookings", "users"
  add_foreign_key "companies", "banks"
  add_foreign_key "flights", "aircrafts"
  add_foreign_key "flights", "airports", column: "arrival_airport_id"
  add_foreign_key "flights", "airports", column: "departure_airport_id"
  add_foreign_key "passengers", "bookings"
  add_foreign_key "passengers", "seats"
  add_foreign_key "seats", "aircrafts"
end
