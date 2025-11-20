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

ActiveRecord::Schema[8.1].define(version: 2025_11_20_154055) do
  create_table "animals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "price"
    t.string "species"
    t.string "unique_id"
    t.datetime "updated_at", null: false
  end

  create_table "event_store_events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.binary "data", null: false
    t.string "event_id", limit: 36, null: false
    t.string "event_type", null: false
    t.binary "metadata"
    t.datetime "valid_at"
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
    t.index ["event_id"], name: "index_event_store_events_on_event_id", unique: true
    t.index ["event_type"], name: "index_event_store_events_on_event_type"
    t.index ["valid_at"], name: "index_event_store_events_on_valid_at"
  end

  create_table "event_store_events_in_streams", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "event_id", limit: 36, null: false
    t.integer "position"
    t.string "stream", null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["event_id"], name: "index_event_store_events_in_streams_on_event_id"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.json "data"
    t.string "type"
    t.datetime "updated_at", null: false
  end

  create_table "onboardings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "animal_id"
    t.boolean "cites_certificate_present", default: true
    t.datetime "created_at", null: false
    t.date "date_received"
    t.string "quarantine_location"
    t.datetime "quarantine_started_at"
    t.string "status"
    t.string "unique_id"
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_onboardings_on_animal_id"
  end

  add_foreign_key "event_store_events_in_streams", "event_store_events", column: "event_id", primary_key: "event_id"
end
