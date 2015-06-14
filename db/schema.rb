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

ActiveRecord::Schema.define(version: 20150613235030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.text     "description"
    t.integer  "company_size"
    t.string   "industry",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url",          limit: 255
    t.string   "company_url",  limit: 255
  end

  add_index "companies", ["company_size"], name: "index_companies_on_company_size", using: :btree
  add_index "companies", ["industry"], name: "index_companies_on_industry", using: :btree
  add_index "companies", ["name"], name: "index_companies_on_name", unique: true, using: :btree
  add_index "companies", ["url"], name: "index_companies_on_url", unique: true, using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "job_applications", force: :cascade do |t|
    t.integer  "job_id",                                       null: false
    t.integer  "applicant_id",                                 null: false
    t.string   "status",       limit: 255, default: "Applied"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note",         limit: 255
  end

  add_index "job_applications", ["applicant_id"], name: "index_job_applications_on_applicant_id", using: :btree
  add_index "job_applications", ["job_id"], name: "index_job_applications_on_job_id", using: :btree
  add_index "job_applications", ["status"], name: "index_job_applications_on_status", using: :btree

  create_table "job_categories", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name", limit: 255
  end

  add_index "job_categories", ["display_name"], name: "index_job_categories_on_display_name", unique: true, using: :btree
  add_index "job_categories", ["name"], name: "index_job_categories_on_name", unique: true, using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "title",           limit: 255,                  null: false
    t.integer  "company_id",                                   null: false
    t.integer  "job_category_id"
    t.string   "url",             limit: 255
    t.integer  "salary_bottom"
    t.integer  "salary_top"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",          limit: 255, default: "Open"
    t.datetime "last_updated"
    t.text     "description"
    t.integer  "location_id"
  end

  add_index "jobs", ["company_id"], name: "index_jobs_on_company_id", using: :btree
  add_index "jobs", ["job_category_id"], name: "index_jobs_on_job_category_id", using: :btree
  add_index "jobs", ["location_id"], name: "index_jobs_on_location_id", using: :btree
  add_index "jobs", ["salary_bottom"], name: "index_jobs_on_salary_bottom", using: :btree
  add_index "jobs", ["salary_top"], name: "index_jobs_on_salary_top", using: :btree
  add_index "jobs", ["status"], name: "index_jobs_on_status", using: :btree
  add_index "jobs", ["title"], name: "index_jobs_on_title", using: :btree
  add_index "jobs", ["url"], name: "index_jobs_on_url", unique: true, using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "region"
    t.string   "postal_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "country"
  end

  add_index "locations", ["city"], name: "index_locations_on_city", using: :btree
  add_index "locations", ["country"], name: "index_locations_on_country", using: :btree
  add_index "locations", ["postal_code"], name: "index_locations_on_postal_code", using: :btree
  add_index "locations", ["region"], name: "index_locations_on_region", using: :btree
  add_index "locations", ["street1"], name: "index_locations_on_street1", using: :btree
  add_index "locations", ["street2"], name: "index_locations_on_street2", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
