# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_12_154828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "c2b_transactions", force: :cascade do |t|
    t.string "transaction_type"
    t.string "trans_id"
    t.string "trans_time"
    t.string "trans_amount"
    t.string "business_short_code"
    t.string "bill_ref_number", limit: 20
    t.string "invoice_number"
    t.string "org_account_balance"
    t.string "third_party_trans_id"
    t.string "msisdn", limit: 12
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.boolean "accepted"
    t.boolean "confirmed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trans_id"], name: "index_c2b_transactions_on_trans_id"
  end

  create_table "paybill_accounts", force: :cascade do |t|
    t.string "name"
    t.bigint "paybill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["paybill_id"], name: "index_paybill_accounts_on_paybill_id"
  end

  create_table "paybill_accounts_users", id: false, force: :cascade do |t|
    t.bigint "paybill_account_id", null: false
    t.bigint "user_id", null: false
    t.index ["paybill_account_id", "user_id"], name: "index_paybill_accounts_users_on_paybill_account_id_and_user_id"
    t.index ["user_id", "paybill_account_id"], name: "index_paybill_accounts_users_on_user_id_and_paybill_account_id"
  end

  create_table "paybills", force: :cascade do |t|
    t.string "paybill_number"
    t.string "consumer_key"
    t.string "consumer_secret"
    t.string "validation_url"
    t.string "confirmation_url"
    t.datetime "last_registration_date"
    t.boolean "last_registration_succeeded"
    t.integer "last_registration_response_code", limit: 2
    t.text "last_registration_response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "paybill_accounts", "paybills"
end
