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

ActiveRecord::Schema.define(version: 20160417074902) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 255,                   comment: "标题"
    t.text     "content",    limit: 65535
    t.string   "author",     limit: 255,                   comment: "作者"
    t.boolean  "status",     limit: 1,                     comment: "状态"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "show_count", limit: 4,                     comment: "浏览次数"
    t.boolean  "tj",         limit: 1,     default: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "file_name",           limit: 255
    t.string   "content_type",        limit: 255
    t.string   "attachmentable_type", limit: 255
    t.string   "file_size",           limit: 255
    t.integer  "attachmentable_id",   limit: 4
    t.string   "attachment",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file",                limit: 255
  end

  create_table "public_resources", force: :cascade do |t|
    t.string   "area",             limit: 255,   comment: "区域"
    t.string   "institution_name", limit: 255,   comment: "机构名称"
    t.string   "level",            limit: 255,   comment: "级别"
    t.string   "genre",            limit: 255,   comment: "类型"
    t.string   "url",              limit: 255,   comment: "网址"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "zc",               limit: 1,     comment: "政采"
    t.boolean  "gt",               limit: 1,     comment: "国土"
    t.boolean  "js",               limit: 1,     comment: "建设"
    t.boolean  "cq",               limit: 1,     comment: "产权"
    t.text     "other",            limit: 65535, comment: "其他"
    t.string   "nature",           limit: 255,   comment: "单位性质"
    t.string   "administrative",   limit: 255,   comment: "行政级别"
    t.string   "pattern",          limit: 255,   comment: "模式"
    t.string   "cities_share",     limit: 255,   comment: "地市共享"
    t.string   "center",           limit: 255,   comment: "政务中心"
    t.string   "center_notice",    limit: 255,   comment: "政采公告"
    t.text     "remark",           limit: 65535, comment: "备注"
    t.integer  "category",         limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "loginname",              limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.integer  "status",                 limit: 4
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.datetime "confirmed_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "locked_at"
    t.integer  "failed_attempts",        limit: 4,   default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["loginname"], name: "index_users_on_loginname", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "pic_url",    limit: 255
  end

end
