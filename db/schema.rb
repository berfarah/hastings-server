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

ActiveRecord::Schema.define(version: 20150925195642) do

  create_table "apps", force: :cascade do |t|
    t.string   "name"
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "instances", force: :cascade do |t|
    t.datetime "finished_at"
    t.boolean  "failed",      default: false
    t.integer  "task_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "job_id"
  end

  add_index "instances", ["job_id"], name: "index_instances_on_job_id"
  add_index "instances", ["task_id"], name: "index_instances_on_task_id"

  create_table "logs", force: :cascade do |t|
    t.string   "severity"
    t.string   "message"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "loggable_type"
    t.integer  "loggable_id"
  end

  add_index "logs", ["loggable_id"], name: "index_logs_on_loggable_id"
  add_index "logs", ["loggable_type"], name: "index_logs_on_loggable_type"

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "script"
    t.string   "scalar"
    t.string   "interval"
    t.boolean  "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "run_at"
  end

end
