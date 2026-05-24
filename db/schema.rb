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

ActiveRecord::Schema[7.2].define(version: 2026_05_24_141359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expert_ratings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "image_id", null: false
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_expert_ratings_on_image_id"
    t.index ["user_id", "image_id"], name: "index_expert_ratings_on_user_id_and_image_id", unique: true
    t.index ["user_id"], name: "index_expert_ratings_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.string "file_name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_images_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "theme_id", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_id"], name: "index_tasks_on_theme_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", limit: 150, null: false
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "expert_ratings", "images"
  add_foreign_key "expert_ratings", "users"
  add_foreign_key "images", "tasks"
  add_foreign_key "tasks", "themes"
  add_foreign_key "tasks", "users"
end
