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

ActiveRecord::Schema.define(version: 2021_10_08_215006) do

  create_table "access_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name", null: false
    t.string "link"
    t.integer "sets", null: false
    t.integer "reps", null: false
    t.integer "rest", null: false
    t.string "tempo", null: false
    t.integer "routine_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["routine_id"], name: "index_exercises_on_routine_id"
  end

  create_table "routines", force: :cascade do |t|
    t.date "day", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["day", "user_id"], name: "index_routines_on_day_and_user_id", unique: true
    t.index ["user_id"], name: "index_routines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "access_tokens", "users"
  add_foreign_key "exercises", "routines"
  add_foreign_key "routines", "users"
end
