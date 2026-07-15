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

ActiveRecord::Schema[8.1].define(version: 2026_07_15_055716) do
  create_table "salons", force: :cascade do |t|
    t.string "area"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "phone_number"
    t.datetime "updated_at", null: false
  end

  create_table "treatment_types", force: :cascade do |t|
    t.integer "category"
    t.datetime "created_at", null: false
    t.integer "standard_cycle_days"
    t.datetime "updated_at", null: false
  end

  create_table "treatments", force: :cascade do |t|
    t.integer "category"
    t.datetime "created_at", null: false
    t.text "memo"
    t.date "next_due_date"
    t.integer "price"
    t.integer "salon_id", null: false
    t.date "treatment_date"
    t.datetime "updated_at", null: false
    t.index ["salon_id"], name: "index_treatments_on_salon_id"
  end

  add_foreign_key "treatments", "salons"
end
