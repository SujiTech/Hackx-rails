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

ActiveRecord::Schema.define(version: 20160924170121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "hstore"

  create_table "attendees", force: :cascade do |t|
    t.string   "name"
    t.integer  "gender"
    t.integer  "education"
    t.boolean  "graduation"
    t.date     "birthday"
    t.string   "school_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "github"
    t.integer  "project_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["email"], name: "index_attendees_on_email", unique: true, using: :btree
    t.index ["project_id"], name: "index_attendees_on_project_id", using: :btree
  end

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",                null: false
    t.string   "uid",        limit: 1000, null: false
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", using: :btree
    t.index ["user_id"], name: "index_authorizations_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.date     "begin_at"
    t.date     "end_at"
    t.datetime "enroll_beigin_at"
    t.datetime "enroll_end_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.text     "description"
    t.string   "cover"
    t.string   "logo"
    t.integer  "organization_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["organization_id"], name: "index_events_on_organization_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_organizations_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "team_name"
    t.string   "tags",                     array: true
    t.text     "description"
    t.hstore   "prize"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_projects_on_event_id", using: :btree
    t.index ["tags"], name: "index_projects_on_tags", using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
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
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "attendees", "projects"
  add_foreign_key "authorizations", "users"
  add_foreign_key "events", "organizations"
  add_foreign_key "organizations", "users"
  add_foreign_key "projects", "events"
end
