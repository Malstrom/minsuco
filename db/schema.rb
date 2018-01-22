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

ActiveRecord::Schema.define(version: 20171009144306) do

  create_table "attendees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "race_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "join_value"
    t.integer "status"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_attendees_on_category_id"
    t.index ["race_id"], name: "index_attendees_on_race_id"
    t.index ["user_id"], name: "index_attendees_on_user_id"
  end

  create_table "authorizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "provider"
    t.string "uid"
    t.integer "user_id"
    t.string "token"
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channel_subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "channel_id"
    t.boolean "email_muted", default: false
    t.boolean "in_app_muted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_subscriptions_on_channel_id"
    t.index ["user_id"], name: "index_channel_subscriptions_on_user_id"
  end

  create_table "channels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "race_id"
    t.decimal "value", precision: 10, scale: 2
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_commissions_on_race_id"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "thing_type"
    t.integer "thing_id"
    t.bigint "who_did_id"
    t.bigint "channel_id"
    t.string "message"
    t.string "previous"
    t.string "now"
    t.boolean "notifiable"
    t.boolean "emailable"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_events_on_channel_id"
    t.index ["who_did_id"], name: "index_events_on_who_did_id"
  end

  create_table "featured_races", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "race_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_featured_races_on_race_id"
  end

  create_table "friends", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "payola_affiliates", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "email"
    t.integer "percent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_coupons", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.integer "percent_off"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "active", default: true
  end

  create_table "payola_sales", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", limit: 191
    t.string "guid", limit: 191
    t.integer "product_id"
    t.string "product_type", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state"
    t.string "stripe_id"
    t.string "stripe_token"
    t.string "card_last4"
    t.date "card_expiration"
    t.string "card_type"
    t.text "error"
    t.integer "amount"
    t.integer "fee_amount"
    t.integer "coupon_id"
    t.boolean "opt_in"
    t.integer "download_count"
    t.integer "affiliate_id"
    t.text "customer_address"
    t.text "business_address"
    t.string "stripe_customer_id", limit: 191
    t.string "currency"
    t.text "signed_custom_fields"
    t.integer "owner_id"
    t.string "owner_type", limit: 100
    t.index ["coupon_id"], name: "index_payola_sales_on_coupon_id"
    t.index ["email"], name: "index_payola_sales_on_email"
    t.index ["guid"], name: "index_payola_sales_on_guid"
    t.index ["owner_id", "owner_type"], name: "index_payola_sales_on_owner_id_and_owner_type"
    t.index ["product_id", "product_type"], name: "index_payola_sales_on_product"
    t.index ["stripe_customer_id"], name: "index_payola_sales_on_stripe_customer_id"
  end

  create_table "payola_stripe_webhooks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_subscriptions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "plan_type"
    t.integer "plan_id"
    t.timestamp "start"
    t.string "status"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "stripe_customer_id"
    t.boolean "cancel_at_period_end"
    t.timestamp "current_period_start"
    t.timestamp "current_period_end"
    t.timestamp "ended_at"
    t.timestamp "trial_start"
    t.timestamp "trial_end"
    t.timestamp "canceled_at"
    t.integer "quantity"
    t.string "stripe_id"
    t.string "stripe_token"
    t.string "card_last4"
    t.date "card_expiration"
    t.string "card_type"
    t.text "error"
    t.string "state"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "currency"
    t.integer "amount"
    t.string "guid", limit: 191
    t.string "stripe_status"
    t.integer "affiliate_id"
    t.string "coupon"
    t.text "signed_custom_fields"
    t.text "customer_address"
    t.text "business_address"
    t.integer "setup_fee"
    t.decimal "tax_percent", precision: 4, scale: 2
    t.index ["guid"], name: "index_payola_subscriptions_on_guid"
  end

  create_table "pieces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "attendee_id"
    t.string "name"
    t.integer "value"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendee_id"], name: "index_pieces_on_attendee_id"
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "stripe_id"
    t.string "interval"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "races", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "owner_id"
    t.string "name"
    t.text "description"
    t.bigint "category_id"
    t.integer "recipients"
    t.integer "race_value"
    t.integer "compensation_start_amount"
    t.integer "kind", default: 1
    t.integer "status"
    t.string "permalink"
    t.integer "price", default: 2900
    t.string "redirect_path", default: "/races"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_races_on_category_id"
    t.index ["owner_id"], name: "index_races_on_owner_id"
  end

  create_table "rewards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.integer "open_races"
    t.integer "join_private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.text "image"
    t.bigint "plan_id"
    t.integer "role"
    t.integer "kind", default: 0
    t.string "rui"
    t.integer "fiscal_kind"
    t.string "phone"
    t.integer "intent"
    t.string "theme", default: "theme-e"
    t.string "redirect_path"
    t.string "state"
    t.string "city"
    t.string "address"
    t.string "address_num"
    t.string "zip"
    t.string "company_name"
    t.string "fiscal_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["plan_id"], name: "index_users_on_plan_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "item_type", limit: 191, null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 4294967295
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "channel_subscriptions", "channels"
  add_foreign_key "channel_subscriptions", "users"
  add_foreign_key "commissions", "races"
  add_foreign_key "events", "users", column: "who_did_id"
  add_foreign_key "featured_races", "races"
  add_foreign_key "friends", "users"
  add_foreign_key "pieces", "attendees"
  add_foreign_key "races", "users", column: "owner_id"
  add_foreign_key "rewards", "users"
  add_foreign_key "users", "plans"
end
