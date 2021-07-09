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

ActiveRecord::Schema.define(version: 2021_07_09_043354) do

  create_table "apply_jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "jobs_id", null: false
    t.binary "cv"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jobs_id"], name: "index_apply_jobs_on_jobs_id"
    t.index ["user_id"], name: "index_apply_jobs_on_user_id"
  end

  create_table "cities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "regions_id", null: false
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["regions_id"], name: "index_cities_on_regions_id"
  end

  create_table "cities_jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cities_id", null: false
    t.bigint "jobs_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cities_id"], name: "index_cities_jobs_on_cities_id"
    t.index ["jobs_id"], name: "index_cities_jobs_on_jobs_id"
  end

  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "total_employee"
    t.string "type"
    t.string "benefits"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies_cities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "companies_id", null: false
    t.bigint "cities_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cities_id"], name: "index_companies_cities_on_cities_id"
    t.index ["companies_id"], name: "index_companies_cities_on_companies_id"
  end

  create_table "favorite_jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "jobs_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jobs_id"], name: "index_favorite_jobs_on_jobs_id"
    t.index ["user_id"], name: "index_favorite_jobs_on_user_id"
  end

  create_table "history_jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "jobs_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jobs_id"], name: "index_history_jobs_on_jobs_id"
    t.index ["user_id"], name: "index_history_jobs_on_user_id"
  end

  create_table "industries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "industries_jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "jobs_id", null: false
    t.bigint "industries_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["industries_id"], name: "index_industries_jobs_on_industries_id"
    t.index ["jobs_id"], name: "index_industries_jobs_on_jobs_id"
  end

  create_table "jobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "companies_id", null: false
    t.string "title"
    t.text "overview"
    t.text "requirement"
    t.text "other_requirement"
    t.integer "salary"
    t.string "type"
    t.string "level"
    t.integer "experience"
    t.string "degree"
    t.string "benefits"
    t.datetime "expired_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["companies_id"], name: "index_jobs_on_companies_id"
  end

  create_table "regions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.binary "cv"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "apply_jobs", "jobs", column: "jobs_id"
  add_foreign_key "apply_jobs", "users"
  add_foreign_key "cities", "regions", column: "regions_id"
  add_foreign_key "cities_jobs", "cities", column: "cities_id"
  add_foreign_key "cities_jobs", "jobs", column: "jobs_id"
  add_foreign_key "companies_cities", "cities", column: "cities_id"
  add_foreign_key "companies_cities", "companies", column: "companies_id"
  add_foreign_key "favorite_jobs", "jobs", column: "jobs_id"
  add_foreign_key "favorite_jobs", "users"
  add_foreign_key "history_jobs", "jobs", column: "jobs_id"
  add_foreign_key "history_jobs", "users"
  add_foreign_key "industries_jobs", "industries", column: "industries_id"
  add_foreign_key "industries_jobs", "jobs", column: "jobs_id"
  add_foreign_key "jobs", "companies", column: "companies_id"
end
