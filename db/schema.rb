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

ActiveRecord::Schema[7.1].define(version: 2024_05_04_220739) do
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
  add_foreign_key "tags", "users"
end
