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

ActiveRecord::Schema[8.0].define(version: 2024_11_22_190812) do
  create_table "campaign_memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "campaign_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_memberships_on_campaign_id"
    t.index ["user_id"], name: "index_campaign_memberships_on_user_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "setting"
    t.boolean "active"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_code"
    t.index ["access_code"], name: "index_campaigns_on_access_code", unique: true
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "race"
    t.string "character_class"
    t.integer "level"
    t.text "backstory"
    t.integer "user_id", null: false
    t.integer "campaign_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_characters_on_campaign_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "session_number"
    t.datetime "date"
    t.text "summary"
    t.integer "campaign_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_sessions_on_campaign_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "user_role", default: "DM"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "campaign_memberships", "campaigns"
  add_foreign_key "campaign_memberships", "users"
  add_foreign_key "campaigns", "users"
  add_foreign_key "characters", "campaigns"
  add_foreign_key "characters", "users"
  add_foreign_key "sessions", "campaigns"
end
