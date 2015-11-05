# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151104033017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string   "name"
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "instances", force: :cascade do |t|
    t.datetime "finished_at"
    t.boolean  "failed",      default: false
    t.integer  "task_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "job_id"
    t.string   "name"
  end

  add_index "instances", ["job_id"], name: "index_instances_on_job_id", using: :btree
  add_index "instances", ["task_id"], name: "index_instances_on_task_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.string   "severity"
    t.string   "message"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "loggable_type"
    t.integer  "loggable_id"
  end

  add_index "logs", ["loggable_id"], name: "index_logs_on_loggable_id", using: :btree
  add_index "logs", ["loggable_type"], name: "index_logs_on_loggable_type", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "script"
    t.string   "scalar"
    t.string   "interval"
    t.boolean  "enabled"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "run_at"
    t.integer  "instances_count", default: 0, null: false
    t.integer  "user_id"
  end

  create_table "updates", force: :cascade do |t|
    t.integer  "updatable_id"
    t.string   "updatable_type"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "updates", ["user_id"], name: "index_updates_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "instances", "tasks"
  add_foreign_key "updates", "users"
end
