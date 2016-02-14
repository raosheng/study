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

ActiveRecord::Schema.define(version: 20160214072904) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 255,   comment: "标题"
    t.text     "content",    limit: 65535
    t.string   "author",     limit: 255,   comment: "作者"
    t.boolean  "status",     limit: 1,     comment: "状态"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "show_count", limit: 4,     comment: "浏览次数"
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
    t.string   "zc",               limit: 255,   comment: "政采"
    t.string   "gt",               limit: 255,   comment: "国土"
    t.string   "js",               limit: 255,   comment: "建设"
    t.string   "cq",               limit: 255,   comment: "产权"
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

  create_table "videos", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "pic_url",    limit: 255
  end

end
