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

ActiveRecord::Schema.define(version: 20150923180154) do

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

  create_table "hastings_instances", force: :cascade do |t|
    t.datetime "finished_at"
    t.boolean  "failed",      default: false
    t.integer  "task_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "hastings_instances", ["task_id"], name: "index_hastings_instances_on_task_id"

  create_table "hastings_logs", force: :cascade do |t|
    t.string   "severity"
    t.string   "message"
    t.integer  "instance_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "hastings_logs", ["instance_id"], name: "index_hastings_logs_on_instance_id"

  create_table "hastings_tasks", force: :cascade do |t|
    t.string   "name"
    t.boolean  "external",   default: false
    t.string   "ip"
    t.string   "script"
    t.string   "scalar"
    t.string   "interval"
    t.boolean  "enabled"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "run_at"
  end

end
