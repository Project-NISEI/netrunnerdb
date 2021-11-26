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

ActiveRecord::Schema.define(version: 20201231061001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "card_types", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_card_types_on_code", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.integer "advancement_requirement"
    t.integer "agenda_points"
    t.integer "base_link"
    t.text "code", null: false
    t.integer "cost"
    t.integer "deck_limit"
    t.integer "faction_id"
    t.integer "influence_cost"
    t.integer "influence_limit"
    t.integer "memory_cost"
    t.integer "minimum_deck_size"
    t.text "name", null: false
    t.integer "side_id"
    t.integer "strength"
    t.text "subtypes"
    t.text "text"
    t.integer "trash_cost"
    t.integer "card_type_id"
    t.boolean "uniqueness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_type_id"], name: "index_cards_on_card_type_id"
    t.index ["code"], name: "index_cards_on_code", unique: true
    t.index ["faction_id"], name: "index_cards_on_faction_id"
    t.index ["side_id"], name: "index_cards_on_side_id"
  end

  create_table "cards_subtypes", id: false, force: :cascade do |t|
    t.integer "card_id", null: false
    t.integer "subtype_id", null: false
    t.index ["subtype_id"], name: "index_cards_subtypes_on_subtype_id"
  end

  create_table "deck_formats", force: :cascade do |t|
    t.text "name", null: false
    t.text "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_deck_formats_on_code", unique: true
  end

  create_table "factions", force: :cascade do |t|
    t.text "code", null: false
    t.boolean "is_mini", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_factions_on_code", unique: true
  end

  create_table "legalities", force: :cascade do |t|
    t.integer "legality_type_id"
    t.integer "deck_format_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_legalities_on_card_id"
    t.index ["deck_format_id", "card_id"], name: "index_legalities_on_deck_format_id_and_card_id", unique: true
    t.index ["deck_format_id"], name: "index_legalities_on_deck_format_id"
    t.index ["legality_type_id"], name: "index_legalities_on_legality_type_id"
  end

  create_table "legality_types", force: :cascade do |t|
    t.text "name", null: false
    t.text "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_legality_types_on_code", unique: true
  end

  create_table "nr_cycles", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_nr_cycles_on_code", unique: true
  end

  create_table "nr_set_types", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_nr_set_types_on_code", unique: true
  end

  create_table "nr_sets", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.date "date_release"
    t.integer "size"
    t.integer "nr_cycle_id"
    t.integer "nr_set_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_nr_sets_on_code", unique: true
    t.index ["nr_cycle_id"], name: "index_nr_sets_on_nr_cycle_id"
    t.index ["nr_set_type_id"], name: "index_nr_sets_on_nr_set_type_id"
  end

  create_table "printings", force: :cascade do |t|
    t.text "printed_text"
    t.boolean "printed_uniqueness"
    t.text "code"
    t.text "flavor"
    t.text "illustrator"
    t.integer "position"
    t.integer "quantity"
    t.date "date_release"
    t.integer "card_id"
    t.integer "nr_set_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_printings_on_card_id"
    t.index ["code"], name: "index_printings_on_code", unique: true
    t.index ["nr_set_id"], name: "index_printings_on_nr_set_id"
  end

  create_table "sides", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_sides_on_code", unique: true
  end

  create_table "subtypes", force: :cascade do |t|
    t.text "code", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_subtypes_on_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "card_types"
  add_foreign_key "cards", "factions"
  add_foreign_key "cards", "sides"
  add_foreign_key "legalities", "cards"
  add_foreign_key "legalities", "deck_formats"
  add_foreign_key "legalities", "legality_types"
  add_foreign_key "nr_sets", "nr_cycles"
  add_foreign_key "nr_sets", "nr_set_types"
  add_foreign_key "printings", "cards"
  add_foreign_key "printings", "nr_sets"
end
