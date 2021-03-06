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

ActiveRecord::Schema.define(version: 20160910195840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "role"
    t.text     "action"
    t.string   "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "state"
    t.string   "host"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string  "content"
    t.integer "player_id"
    t.integer "game_id"
    t.index ["game_id"], name: "index_messages_on_game_id", using: :btree
    t.index ["player_id"], name: "index_messages_on_player_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "nickname"
    t.string   "final_card"
    t.integer  "votes",      default: 0
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["card_id"], name: "index_players_on_card_id", using: :btree
    t.index ["game_id"], name: "index_players_on_game_id", using: :btree
    t.index ["user_id"], name: "index_players_on_user_id", using: :btree
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "game_id"
    t.boolean  "complete"
    t.boolean  "current"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_rounds_on_game_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "messages", "games"
  add_foreign_key "messages", "players"
  add_foreign_key "players", "cards"
  add_foreign_key "players", "games"
  add_foreign_key "players", "users"
end
