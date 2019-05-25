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

ActiveRecord::Schema.define(version: 2019_05_25_003047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_donations_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_donations_on_user_id_and_organization_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "fb_url"
    t.string "org_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fb_url"], name: "index_organizations_on_fb_url", unique: true
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["org_type"], name: "index_organizations_on_org_type"
  end

  create_table "user_favorite_organizations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_user_favorite_organizations_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_user_fav_orgs_on_user_id_and_org_id", unique: true
    t.index ["user_id"], name: "index_user_favorite_organizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nick_name"
    t.string "fb_id"
    t.string "email"
    t.string "favorite_cause"
    t.string "favorite_cause_description"
    t.string "philosophy"
    t.string "address"
    t.integer "yearly_income"
    t.string "pic_url"
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "uid"
    t.string "provider"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["favorite_cause"], name: "index_users_on_favorite_cause"
    t.index ["fb_id"], name: "index_users_on_fb_id", unique: true
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["location"], name: "index_users_on_location"
    t.index ["yearly_income"], name: "index_users_on_yearly_income"
  end

  add_foreign_key "donations", "organizations"
  add_foreign_key "donations", "users"
  add_foreign_key "user_favorite_organizations", "organizations"
  add_foreign_key "user_favorite_organizations", "users"
end
