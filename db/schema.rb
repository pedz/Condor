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

ActiveRecord::Schema.define(:version => 20080917174151) do

  create_table "aix_files", :force => true do |t|
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aix_files", ["path"], :name => "unique_aix_files_path", :unique => true

  create_table "apar_defect_ptf_release_maps", :force => true do |t|
    t.integer  "apar_id"
    t.integer  "defect_id"
    t.integer  "ptf_id"
    t.integer  "release_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apar_defect_ptf_release_maps", ["defect_id"], :name => "apar_defect_ptf_release_maps_defect_idx"
  add_index "apar_defect_ptf_release_maps", ["ptf_id"], :name => "apar_defect_ptf_release_maps_ptf_idx"
  add_index "apar_defect_ptf_release_maps", ["release_id"], :name => "apar_defect_ptf_release_maps_release_idx"
  add_index "apar_defect_ptf_release_maps", ["apar_id", "defect_id", "ptf_id", "release_id"], :name => "unique_apar_defect_ptf_release_map_apar_defect_ptf_release", :unique => true

  create_table "apars", :force => true do |t|
    t.string   "name"
    t.string   "abstract"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apars", ["name"], :name => "unique_apar_name", :unique => true

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

  create_table "fileset_aix_file_maps", :force => true do |t|
    t.integer  "fileset_id"
    t.integer  "aix_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fileset_aix_file_maps", ["aix_file_id", "fileset_id"], :name => "unique_fileset_aix_file_map_fileset_aix_file", :unique => true

  create_table "fileset_ptf_maps", :force => true do |t|
    t.integer  "fileset_id", :null => false
    t.integer  "ptf_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fileset_ptf_maps", ["ptf_id"], :name => "fileset_ptf_maps_ptf_idx"
  add_index "fileset_ptf_maps", ["fileset_id", "ptf_id"], :name => "unique_fileset_ptf_map_fileset_ptf", :unique => true

  create_table "filesets", :force => true do |t|
    t.integer  "lpp_id",     :null => false
    t.string   "vrmf"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "filesets", ["lpp_id", "vrmf"], :name => "unique_fileset_lpp_id_vrmf", :unique => true

  create_table "image_path_fileset_maps", :force => true do |t|
    t.integer  "image_path_id"
    t.integer  "fileset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_path_fileset_maps", ["fileset_id", "image_path_id"], :name => "unique_image_path_fileset_map_image_path_fileset", :unique => true

  create_table "image_path_package_maps", :force => true do |t|
    t.integer  "image_path_id"
    t.integer  "package_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_path_package_maps", ["image_path_id", "package_id"], :name => "unique_image_path_package_maps_image_path_package", :unique => true

  create_table "image_paths", :force => true do |t|
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_paths", ["path"], :name => "unique_image_path_path", :unique => true

  create_table "lpp_bases", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lpp_bases", ["name"], :name => "unique_lpp_base_name", :unique => true

  create_table "lpps", :force => true do |t|
    t.string   "name"
    t.integer  "lpp_base_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lpps", ["lpp_base_id", "name"], :name => "unique_lpp_name", :unique => true

  create_table "package_fileset_maps", :force => true do |t|
    t.integer  "package_id"
    t.integer  "fileset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_fileset_maps", ["fileset_id", "package_id"], :name => "unique_package_fileset_map_package_fileset", :unique => true

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packages", ["name"], :name => "unique_package_name", :unique => true

  create_table "ptfs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ptfs", ["name"], :name => "unique_ptf_name", :unique => true

  create_table "releases", :force => true do |t|
    t.string   "name"
    t.integer  "family_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "releases", ["family_id", "name"], :name => "unique_release_name", :unique => true

  create_table "service_pack_fileset_maps", :force => true do |t|
    t.integer  "service_pack_id", :null => false
    t.integer  "fileset_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_pack_fileset_maps", ["fileset_id"], :name => "service_pack_fileset_maps_fileset_idx"
  add_index "service_pack_fileset_maps", ["fileset_id", "service_pack_id"], :name => "unique_service_pack_fileset_map_service_pack_fileset", :unique => true

  create_table "service_packs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_packs", ["name"], :name => "unique_service_pack_name", :unique => true

end
