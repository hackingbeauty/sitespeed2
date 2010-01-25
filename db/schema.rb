# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100122215500) do

  create_table "events", :force => true do |t|
    t.string   "type"
    t.binary   "url_prefix"
    t.text     "title"
    t.datetime "start"
    t.datetime "end"
    t.binary   "resource_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["start"], :name => "index_events_on_start", :unique => true

  create_table "page_speeds", :force => true do |t|
    t.integer  "ip"
    t.text     "user_agent"
    t.integer  "url_id"
    t.integer  "w"
    t.float    "o"
    t.integer  "l"
    t.integer  "r"
    t.integer  "t"
    t.text     "v"
    t.float    "pMinifyCSS"
    t.float    "pMinifyJS"
    t.float    "pOptImgs"
    t.float    "pImgDims"
    t.float    "pCombineJS"
    t.float    "pCombineCSS"
    t.float    "pCssInHead"
    t.float    "pBrowserCache"
    t.float    "pProxyCache"
    t.float    "pNoCookie"
    t.float    "pCookieSize"
    t.float    "pParallelDl"
    t.float    "pCssSelect"
    t.float    "pCssJsOrder"
    t.float    "pDeferJS"
    t.float    "pGzip"
    t.float    "pMinRedirect"
    t.float    "pCssExpr"
    t.float    "pUnusedCSS"
    t.float    "pMinDNS"
    t.float    "pDudeRsrc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_speeds", ["url_id"], :name => "index_page_speeds_on_url_id", :unique => true

  create_table "urls", :force => true do |t|
    t.binary   "url"
    t.datetime "last_update"
    t.datetime "last_event_update"
    t.integer  "w"
    t.integer  "o"
    t.integer  "r"
    t.integer  "ps_w"
    t.float    "ps_o"
    t.integer  "ps_l"
    t.integer  "ps_r"
    t.integer  "ps_t"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "urls", ["last_update"], :name => "index_urls_on_last_update", :unique => true

  create_table "yslow2s", :force => true do |t|
    t.integer  "url_id"
    t.integer  "ip"
    t.text     "user_agent"
    t.integer  "w"
    t.integer  "o"
    t.integer  "r"
    t.text     "i"
    t.integer  "lt"
    t.integer  "ynumreq"
    t.integer  "ycdn"
    t.integer  "yexpires"
    t.integer  "ycompress"
    t.integer  "ycsstop"
    t.integer  "yjsbottom"
    t.integer  "yexpressions"
    t.integer  "yexternal"
    t.integer  "ydns"
    t.integer  "yminify"
    t.integer  "yredirects"
    t.integer  "ydupes"
    t.integer  "yetags"
    t.integer  "yxhr"
    t.integer  "yxhrmethod"
    t.integer  "ymindom"
    t.integer  "yno404"
    t.integer  "ymincookie"
    t.integer  "ycookiefree"
    t.integer  "ynofilter"
    t.integer  "yimgnoscale"
    t.integer  "yfavicon"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "yslow2s", ["url_id"], :name => "index_yslow2s_on_url_id", :unique => true

  create_table "yslows", :force => true do |t|
    t.integer  "url_id"
    t.integer  "ip"
    t.text     "user_agent"
    t.integer  "w"
    t.integer  "o"
    t.text     "u"
    t.integer  "r"
    t.integer  "numcomps"
    t.integer  "cdn"
    t.integer  "expires"
    t.integer  "gzip"
    t.integer  "cssattop"
    t.integer  "jsatbottom"
    t.integer  "expression"
    t.integer  "domains"
    t.integer  "obfuscate"
    t.integer  "redirects"
    t.integer  "jstwice"
    t.integer  "etags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
