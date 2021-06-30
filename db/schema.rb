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

ActiveRecord::Schema.define(version: 2021_06_28_135630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_logs", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.integer "payment", null: false, comment: "報酬額（税抜き）"
    t.datetime "started_at", null: false, comment: "開始時間"
    t.datetime "finished_at", comment: "終了時間"
    t.text "comment", comment: "稼働内容等"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_id"], name: "index_activity_logs_on_contract_id"
    t.index ["finished_at"], name: "index_activity_logs_on_finished_at"
    t.index ["started_at"], name: "index_activity_logs_on_started_at"
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.text "logo_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.integer "hourly_payment", null: false, comment: "時給（税抜）"
    t.datetime "expired_at", comment: "契約終了日時"
    t.integer "expired_reason", comment: "契約終了理由"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_contracts_on_client_id"
  end

  create_table "rest_logs", force: :cascade do |t|
    t.bigint "activity_log_id", null: false
    t.datetime "started_at", null: false, comment: "休憩開始日時"
    t.datetime "finished_at", comment: "休憩終了日時"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_log_id"], name: "index_rest_logs_on_activity_log_id"
    t.index ["finished_at"], name: "index_rest_logs_on_finished_at"
    t.index ["started_at"], name: "index_rest_logs_on_started_at"
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

  add_foreign_key "activity_logs", "contracts"
  add_foreign_key "clients", "users"
  add_foreign_key "contracts", "clients"
  add_foreign_key "rest_logs", "activity_logs"
end
