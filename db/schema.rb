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

ActiveRecord::Schema[7.1].define(version: 2024_05_06_015828) do
  create_table "categories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", limit: 100, null: false
    t.text "description"
    t.string "icon_url"
    t.integer "priority", null: false
    t.boolean "active", default: true
    t.boolean "is_public", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "claimed_categories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_claimed_categories_on_category_id"
    t.index ["user_id", "category_id"], name: "index_claimed_categories_on_user_id_and_category_id", unique: true
    t.index ["user_id"], name: "index_claimed_categories_on_user_id"
  end

  create_table "claimed_tags", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_claimed_tags_on_tag_id"
    t.index ["user_id", "tag_id"], name: "index_claimed_tags_on_user_id_and_tag_id", unique: true
    t.index ["user_id"], name: "index_claimed_tags_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "address", limit: 255
    t.string "zip_code", limit: 50
    t.integer "restaurant_id", null: false
    t.integer "city_id", null: false
    t.integer "state_id", null: false
    t.integer "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_locations_on_city_id"
    t.index ["country_id"], name: "index_locations_on_country_id"
    t.index ["name", "address"], name: "index_locations_on_name_and_address", unique: true
    t.index ["restaurant_id"], name: "index_locations_on_restaurant_id"
    t.index ["state_id"], name: "index_locations_on_state_id"
  end

  create_table "restaurant_categories", force: :cascade do |t|
    t.integer "restaurant_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_restaurant_categories_on_category_id"
    t.index ["restaurant_id", "category_id"], name: "index_restaurant_categories_on_restaurant_id_and_category_id", unique: true
    t.index ["restaurant_id"], name: "index_restaurant_categories_on_restaurant_id"
  end

  create_table "restaurant_tags", force: :cascade do |t|
    t.integer "restaurant_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id", "tag_id"], name: "index_restaurant_tags_on_restaurant_id_and_tag_id", unique: true
    t.index ["restaurant_id"], name: "index_restaurant_tags_on_restaurant_id"
    t.index ["tag_id"], name: "index_restaurant_tags_on_tag_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", limit: 100
    t.text "description"
    t.integer "contact_information_type"
    t.string "contact_information", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_restaurants_on_name", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "restaurant_id", null: false
    t.string "title", limit: 100, null: false
    t.text "content"
    t.date "visit_date", null: false
    t.boolean "recommendation", null: false
    t.integer "rating", null: false
    t.integer "ambience_rating"
    t.integer "service_rating"
    t.integer "wait_time"
    t.boolean "value_for_money"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
    t.index ["user_id", "restaurant_id"], name: "index_reviews_on_user_id_and_restaurant_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", limit: 100
    t.text "description"
    t.integer "priority"
    t.boolean "active", default: false
    t.boolean "is_public", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255
    t.string "password_digest", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "claimed_categories", "categories"
  add_foreign_key "claimed_categories", "users"
  add_foreign_key "claimed_tags", "tags"
  add_foreign_key "claimed_tags", "users"
  add_foreign_key "locations", "cities"
  add_foreign_key "locations", "countries"
  add_foreign_key "locations", "restaurants"
  add_foreign_key "locations", "states"
  add_foreign_key "restaurant_categories", "categories"
  add_foreign_key "restaurant_categories", "restaurants"
  add_foreign_key "restaurant_tags", "restaurants"
  add_foreign_key "restaurant_tags", "tags"
  add_foreign_key "reviews", "restaurants"
  add_foreign_key "reviews", "users"
  add_foreign_key "tags", "users"
end
