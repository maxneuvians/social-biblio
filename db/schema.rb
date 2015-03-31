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

ActiveRecord::Schema.define(version: 20140522200848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "admins", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libraries", force: true do |t|
    t.string   "twitter_id"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.text     "raw"
    t.string   "tweet_id"
    t.integer  "library_id",       default: 0
    t.text     "content"
    t.string   "username"
    t.string   "in_reply_to"
    t.integer  "followers"
    t.text     "hashtags",         default: [], array: true
    t.text     "urls",             default: [], array: true
    t.text     "mentions",         default: [], array: true
    t.datetime "tweet_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["hashtags"], name: "index_tweets_on_hashtags", using: :gin
  add_index "tweets", ["library_id"], name: "index_tweets_on_library_id", using: :btree
  add_index "tweets", ["mentions"], name: "index_tweets_on_mentions", using: :gin
  add_index "tweets", ["urls"], name: "index_tweets_on_urls", using: :gin

end
