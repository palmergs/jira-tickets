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

ActiveRecord::Schema.define(version: 2020_01_23_222503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issue_components", force: :cascade do |t|
    t.bigint "issue_id", null: false
    t.string "name", limit: 30, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["issue_id"], name: "index_issue_components_on_issue_id"
    t.index ["name"], name: "index_issue_components_on_name"
  end

  create_table "issues", force: :cascade do |t|
    t.string "project", limit: 10
    t.string "project_name", limit: 30
    t.string "issue_type", limit: 20
    t.string "issue_key", limit: 30
    t.bigint "issue_id", null: false
    t.integer "story_points", default: 0, null: false
    t.string "summary"
    t.string "assignee"
    t.string "status", limit: 30
    t.string "resolution", limit: 30
    t.datetime "issue_updated_at"
    t.datetime "issue_created_at"
    t.datetime "resolved_at"
    t.string "priority", limit: 30
    t.string "ticket_origin", limit: 30
    t.string "origin", limit: 30
    t.string "product_component", limit: 30
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["issue_created_at"], name: "index_issues_on_issue_created_at"
    t.index ["issue_id"], name: "index_issues_on_issue_id", unique: true
    t.index ["issue_key"], name: "index_issues_on_issue_key"
    t.index ["issue_type"], name: "index_issues_on_issue_type"
    t.index ["issue_updated_at"], name: "index_issues_on_issue_updated_at"
    t.index ["origin"], name: "index_issues_on_origin"
    t.index ["priority"], name: "index_issues_on_priority"
    t.index ["project"], name: "index_issues_on_project"
    t.index ["resolution"], name: "index_issues_on_resolution"
    t.index ["resolved_at"], name: "index_issues_on_resolved_at"
    t.index ["status"], name: "index_issues_on_status"
    t.index ["ticket_origin"], name: "index_issues_on_ticket_origin"
  end

  add_foreign_key "issue_components", "issues"
end
