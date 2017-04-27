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

ActiveRecord::Schema.define(version: 20170427182703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "merchants", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "oauth_uid"
    t.string   "oauth_email"
    t.string   "oauth_provider"
  end

  create_table "orderedproducts", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "product_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "shipped"
    t.index ["order_id"], name: "index_orderedproducts_on_order_id", using: :btree
    t.index ["product_id"], name: "index_orderedproducts_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "mailing_address"
    t.string   "name_on_cc"
    t.integer  "cc_num"
    t.string   "cc_exp"
    t.integer  "cc_csv"
    t.integer  "zip_code"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.string   "category"
    t.text     "description"
    t.integer  "inventory"
    t.string   "photo_url"
    t.integer  "merchant_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "retired"
    t.index ["merchant_id"], name: "index_products_on_merchant_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_reviews_on_product_id", using: :btree
  end

end
