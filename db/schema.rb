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

ActiveRecord::Schema.define(version: 20140714180204) do

  create_table "companies", force: true do |t|
    t.string   "name",         null: false
    t.string   "description"
    t.integer  "company_size"
    t.string   "industry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "company_url"
  end

  add_index "companies", ["company_size"], name: "index_companies_on_company_size"
  add_index "companies", ["industry"], name: "index_companies_on_industry"
  add_index "companies", ["name"], name: "index_companies_on_name", unique: true
  add_index "companies", ["url"], name: "index_companies_on_url", unique: true

  create_table "job_applications", force: true do |t|
    t.integer  "job_id",                           null: false
    t.integer  "applicant_id",                     null: false
    t.string   "status",       default: "Applied"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note"
  end

  add_index "job_applications", ["applicant_id"], name: "index_job_applications_on_applicant_id"
  add_index "job_applications", ["job_id"], name: "index_job_applications_on_job_id"
  add_index "job_applications", ["status"], name: "index_job_applications_on_status"

  create_table "job_categories", force: true do |t|
    t.string   "name",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

  add_index "job_categories", ["display_name"], name: "index_job_categories_on_display_name", unique: true
  add_index "job_categories", ["name"], name: "index_job_categories_on_name", unique: true

  create_table "jobs", force: true do |t|
    t.string   "title",                            null: false
    t.integer  "company_id",                       null: false
    t.integer  "job_category_id"
    t.string   "url"
    t.integer  "salary_bottom"
    t.integer  "salary_top"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",          default: "Open"
  end

  add_index "jobs", ["company_id"], name: "index_jobs_on_company_id"
  add_index "jobs", ["job_category_id"], name: "index_jobs_on_job_category_id"
  add_index "jobs", ["salary_bottom"], name: "index_jobs_on_salary_bottom"
  add_index "jobs", ["salary_top"], name: "index_jobs_on_salary_top"
  add_index "jobs", ["status"], name: "index_jobs_on_status"
  add_index "jobs", ["title"], name: "index_jobs_on_title"
  add_index "jobs", ["url"], name: "index_jobs_on_url", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
