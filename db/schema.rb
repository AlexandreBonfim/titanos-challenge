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

ActiveRecord::Schema[8.0].define(version: 2025_11_19_094557) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_apps_on_name", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "app_id", null: false
    t.string "available_type", null: false
    t.bigint "available_id", null: false
    t.string "market", null: false
    t.jsonb "stream_info", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id", "market"], name: "index_availabilities_on_app_id_and_market"
    t.index ["app_id"], name: "index_availabilities_on_app_id"
    t.index ["available_type", "available_id"], name: "index_availabilities_on_available"
    t.index ["market"], name: "index_availabilities_on_market"
  end

  create_table "channel_programs", force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.string "original_title", null: false
    t.integer "year"
    t.integer "duration_in_seconds"
    t.jsonb "schedule", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_programs_on_channel_id"
    t.index ["original_title"], name: "index_channel_programs_on_original_title"
  end

  create_table "channels", force: :cascade do |t|
    t.string "original_title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "episodes", force: :cascade do |t|
    t.bigint "tv_show_id", null: false
    t.bigint "season_id", null: false
    t.string "original_title"
    t.integer "number"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_episodes_on_season_id"
    t.index ["tv_show_id"], name: "index_episodes_on_tv_show_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "original_title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.bigint "tv_show_id", null: false
    t.string "original_title"
    t.integer "number"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_show_id"], name: "index_seasons_on_tv_show_id"
  end

  create_table "tv_shows", force: :cascade do |t|
    t.string "original_title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "watch_events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.bigint "channel_program_id", null: false
    t.integer "watched_seconds", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_program_id"], name: "index_watch_events_on_channel_program_id"
    t.index ["user_id", "channel_program_id"], name: "index_watch_events_on_user_id_and_channel_program_id", unique: true
  end

  add_foreign_key "availabilities", "apps"
  add_foreign_key "channel_programs", "channels"
  add_foreign_key "episodes", "seasons"
  add_foreign_key "episodes", "tv_shows"
  add_foreign_key "seasons", "tv_shows"
  add_foreign_key "watch_events", "channel_programs"
end
