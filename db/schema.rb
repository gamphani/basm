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

ActiveRecord::Schema.define(:version => 20090908081115) do

  create_table "observations", :force => true do |t|
    t.integer  "server_id"
    t.integer  "service_id"
    t.string   "observation_key",       :limit => 32, :null => false
    t.float    "observation_value"
    t.datetime "observation_date_time"
    t.datetime "created_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "name",       :limit => 32, :null => false
    t.string   "location"
    t.datetime "created_at"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string   "uname",      :limit => 15, :null => false
    t.string   "passwd",     :limit => 12
    t.string   "role",       :limit => 13, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
