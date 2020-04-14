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

ActiveRecord::Schema.define(version: 2020_04_14_213558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "debts", force: :cascade do |t|
    t.string "kind"
    t.integer "value"
    t.integer "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "occupation"
    t.string "identification"
    t.integer "age"
    t.integer "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.index ["identification"], name: "index_members_on_identification", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "county"
    t.string "owner_name"
    t.integer "auction_amount"
    t.integer "arv"
    t.string "property_type"
    t.integer "number_of_bedrooms"
    t.integer "number_of_bathrooms"
    t.integer "home_sqr_footage"
    t.integer "property_sqr_footage"
    t.string "found_by"
    t.string "secondary_revision"
    t.string "type_of_loan"
    t.string "home_status"
    t.string "notes"
    t.string "agent"
    t.date "review_by_date"
    t.boolean "urgent"
    t.string "possible_phone_numbers"
    t.string "possible_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auction_type"
    t.datetime "auction_date"
    t.boolean "archive", default: false
    t.integer "profit"
    t.integer "created_by"
    t.string "archived_by"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
