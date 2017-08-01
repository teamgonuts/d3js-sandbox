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

ActiveRecord::Schema.define(version: 20170801180411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flickr_photos", force: :cascade do |t|
    t.string   "city_name",         null: false
    t.string   "photo_id",          null: false
    t.string   "owner_id"
    t.string   "owner_name"
    t.string   "title"
    t.decimal  "lat",               null: false
    t.decimal  "lng",               null: false
    t.string   "accuracy"
    t.string   "place_id"
    t.string   "url_z"
    t.string   "height_z"
    t.string   "width_z"
    t.string   "date_uploaded"
    t.string   "date_taken_string"
    t.datetime "date_taken"
    t.string   "taken_granularity"
    t.string   "photo_page_url"
  end

end
