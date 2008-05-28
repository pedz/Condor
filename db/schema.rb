# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 14) do

  create_table "apar_defect_maps", :force => true do |t|
    t.integer  "apar_id"
    t.integer  "defect_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apar_defect_maps", ["apar_id", "defect_id"], :name => "unique_apar_defect_map_apar_defect", :unique => true

  create_table "apar_ptf_maps", :force => true do |t|
    t.integer  "apar_id"
    t.integer  "ptf_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apar_ptf_maps", ["apar_id", "ptf_id"], :name => "unique_apar_ptf_map_apar_ptf", :unique => true

  create_table "apars", :force => true do |t|
    t.string   "name"
    t.string   "abstract"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apars", ["name"], :name => "unique_apar_name", :unique => true

  create_table "bases", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bases", ["name"], :name => "unique_base_name", :unique => true

  create_table "defect_release_maps", :force => true do |t|
    t.integer  "defect_id"
    t.integer  "release_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "defect_release_maps", ["defect_id", "release_id"], :name => "unique_defect_release_map_defect_release", :unique => true

  create_table "defects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "defects", ["name"], :name => "unique_defect_name", :unique => true

  create_table "families", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "families", ["name"], :name => "unique_familie_name", :unique => true

  create_table "fileset_ptf_maps", :force => true do |t|
    t.integer  "fileset_id"
    t.integer  "ptf_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fileset_ptf_maps", ["fileset_id", "ptf_id"], :name => "unique_fileset_ptf_map_fileset_ptf", :unique => true

  create_table "filesets", :force => true do |t|
    t.integer  "lpp_id"
    t.string   "vrmf"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "filesets", ["lpp_id", "vrmf"], :name => "unique_fileset_lpp_id_vrmf", :unique => true

  create_table "lpps", :force => true do |t|
    t.string   "name"
    t.integer  "base_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lpps", ["name"], :name => "unique_lpp_name", :unique => true

  create_table "ptfs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ptfs", ["name"], :name => "unique_ptf_name", :unique => true

  create_table "releases", :force => true do |t|
    t.string   "name"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "releases", ["name"], :name => "unique_release_name", :unique => true

  create_table "service_pack_fileset_maps", :force => true do |t|
    t.integer  "service_pack_id"
    t.integer  "fileset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_pack_fileset_maps", ["service_pack_id", "fileset_id"], :name => "unique_service_pack_fileset_map_service_pack_fileset", :unique => true

  create_table "service_packs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_packs", ["name"], :name => "unique_service_pack_name", :unique => true

end
