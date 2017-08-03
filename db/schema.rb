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

ActiveRecord::Schema.define(version: 20170802082438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "building_tier_resources", force: :cascade do |t|
    t.bigint "building_tier_id"
    t.bigint "resource_id"
    t.integer "quantity"
    t.float "increase"
    t.index ["building_tier_id", "resource_id"], name: "idx_building_tier_resources_unique", unique: true
    t.index ["building_tier_id"], name: "index_building_tier_resources_on_building_tier_id"
    t.index ["resource_id"], name: "index_building_tier_resources_on_resource_id"
  end

  create_table "building_tiers", force: :cascade do |t|
    t.bigint "building_id"
    t.integer "tier"
    t.index ["building_id", "tier"], name: "index_building_tiers_on_building_id_and_tier", unique: true
    t.index ["building_id"], name: "index_building_tiers_on_building_id"
  end

  create_table "buildings", force: :cascade do |t|
    t.bigint "main_id"
    t.integer "maximum", default: 1
    t.index ["main_id"], name: "index_buildings_on_main_id"
  end

  create_table "chief_buildings", force: :cascade do |t|
    t.bigint "chief_id"
    t.bigint "building_id"
    t.integer "level"
    t.integer "tier"
    t.datetime "last_collect_time", default: "2017-08-02 17:18:27"
    t.index ["building_id"], name: "index_chief_buildings_on_building_id"
    t.index ["chief_id"], name: "index_chief_buildings_on_chief_id"
  end

  create_table "chief_resources", force: :cascade do |t|
    t.bigint "chief_id"
    t.bigint "resource_id"
    t.integer "quantity"
    t.index ["chief_id"], name: "index_chief_resources_on_chief_id"
    t.index ["resource_id"], name: "index_chief_resources_on_resource_id"
  end

  create_table "chiefs", force: :cascade do |t|
    t.bigint "user_id"
    t.index ["user_id"], name: "index_chiefs_on_user_id"
  end

  create_table "gather_building_tiers", force: :cascade do |t|
    t.bigint "gather_building_id"
    t.integer "tier"
    t.integer "capacity"
    t.integer "rps"
    t.float "increase"
    t.index ["gather_building_id", "tier"], name: "index_gather_building_tiers_on_gather_building_id_and_tier", unique: true
    t.index ["gather_building_id"], name: "index_gather_building_tiers_on_gather_building_id"
  end

  create_table "gather_buildings", force: :cascade do |t|
    t.bigint "building_id"
    t.bigint "resource_id"
    t.index ["building_id"], name: "index_gather_buildings_on_building_id"
    t.index ["resource_id"], name: "index_gather_buildings_on_resource_id"
  end

  create_table "mains", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.index ["name"], name: "index_mains_on_name", unique: true
  end

  create_table "resources", force: :cascade do |t|
    t.bigint "main_id"
    t.index ["main_id"], name: "index_resources_on_main_id"
  end

  create_table "starter_buildings", force: :cascade do |t|
    t.bigint "building_id"
    t.index ["building_id"], name: "index_starter_buildings_on_building_id"
  end

  create_table "starter_resources", force: :cascade do |t|
    t.bigint "resource_id"
    t.integer "quantity"
    t.index ["resource_id"], name: "index_starter_resources_on_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "building_tier_resources", "building_tiers"
  add_foreign_key "building_tier_resources", "resources"
  add_foreign_key "building_tiers", "buildings"
  add_foreign_key "buildings", "mains"
  add_foreign_key "chief_buildings", "buildings"
  add_foreign_key "chief_buildings", "chiefs"
  add_foreign_key "chief_resources", "chiefs"
  add_foreign_key "chief_resources", "resources"
  add_foreign_key "chiefs", "users"
  add_foreign_key "gather_building_tiers", "gather_buildings"
  add_foreign_key "gather_buildings", "buildings"
  add_foreign_key "gather_buildings", "resources"
  add_foreign_key "resources", "mains"
  add_foreign_key "starter_buildings", "buildings"
  add_foreign_key "starter_resources", "resources"
end
