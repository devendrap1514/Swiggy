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

ActiveRecord::Schema[7.0].define(version: 2023_09_08_054940) do
  create_table "carts", force: :cascade do |t|
    t.decimal "cart_price"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dishes", force: :cascade do |t|
    t.string "dish_name"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_dishes_on_category_id"
  end

  create_table "item_statuses", force: :cascade do |t|
    t.integer "restaurant_dish_id"
    t.string "status_type", null: false
    t.integer "status_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_dish_id"], name: "index_item_statuses_on_restaurant_dish_id"
    t.index ["status_type", "status_id"], name: "index_item_statuses_on_status"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "order_price"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "restaurant_dishes", force: :cascade do |t|
    t.integer "restaurant_id", null: false
    t.integer "dish_id", null: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_restaurant_dishes_on_dish_id"
    t.index ["restaurant_id"], name: "index_restaurant_dishes_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "restaurant_name"
    t.string "address"
    t.string "status"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carts", "users"
  add_foreign_key "dishes", "categories"
  add_foreign_key "item_statuses", "restaurant_dishes"
  add_foreign_key "orders", "users"
  add_foreign_key "restaurant_dishes", "dishes"
  add_foreign_key "restaurant_dishes", "restaurants"
  add_foreign_key "restaurants", "users"
end
