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

ActiveRecord::Schema[7.1].define(version: 2024_07_23_040210) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "charities", force: :cascade do |t|
    t.string "charity_name", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charity_codes", force: :cascade do |t|
    t.bigint "charity_id", null: false
    t.string "status", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "applicant_id", null: false
    t.bigint "requester_id", null: false
    t.bigint "application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_chats_on_applicant_id"
    t.index ["application_id"], name: "index_chats_on_application_id"
    t.index ["requester_id"], name: "index_chats_on_requester_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "company_code", limit: 20, null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_charities", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "charity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_codes", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "status", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "message_text", null: false
    t.boolean "read", null: false
    t.bigint "chat_id"
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "header", null: false
    t.string "message", null: false
    t.string "url", null: false
    t.boolean "read", default: false
    t.boolean "show", default: true
    t.bigint "notification_for_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_for_id"], name: "index_notifications_on_notification_for_id"
  end

  create_table "request_applications", force: :cascade do |t|
    t.string "status", default: "Pending", null: false
    t.bigint "applicant_id", null: false
    t.bigint "request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_request_applications_on_applicant_id"
    t.index ["request_id"], name: "index_request_applications_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "category", null: false
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.date "date", null: false
    t.time "start_time", null: false
    t.integer "number_of_pax", null: false
    t.integer "duration", null: false
    t.string "reward_type", null: false
    t.string "reward"
    t.string "status", null: false
    t.bigint "created_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", null: false
    t.text "review_content"
    t.bigint "request_id", null: false
    t.bigint "review_for", null: false
    t.bigint "review_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "summary_reports", force: :cascade do |t|
    t.bigint "requested_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_reports", force: :cascade do |t|
    t.text "report_reason", null: false
    t.string "status", null: false
    t.bigint "requested_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "number", default: ""
    t.string "description", default: ""
    t.string "status", default: "active", null: false
    t.bigint "role_id", default: 1
    t.bigint "company_id"
    t.bigint "charity_id"
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_number"
    t.index ["charity_id"], name: "index_users_on_charity_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["number"], name: "index_users_on_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "charity_codes", "charities"
  add_foreign_key "chats", "requests"
  add_foreign_key "chats", "users", column: "applicant_id"
  add_foreign_key "chats", "users", column: "requester_id"
  add_foreign_key "company_charities", "charities"
  add_foreign_key "company_charities", "companies"
  add_foreign_key "company_codes", "companies"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "notifications", "users", column: "notification_for_id"
  add_foreign_key "request_applications", "requests"
  add_foreign_key "request_applications", "users", column: "applicant_id"
  add_foreign_key "requests", "users", column: "created_by"
  add_foreign_key "reviews", "requests"
  add_foreign_key "reviews", "users", column: "review_by"
  add_foreign_key "reviews", "users", column: "review_for"
  add_foreign_key "summary_reports", "users", column: "requested_by"
  add_foreign_key "user_reports", "users", column: "requested_by"
  add_foreign_key "users", "charities"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "roles"
end
