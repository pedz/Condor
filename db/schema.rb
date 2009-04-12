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

ActiveRecord::Schema.define(:version => 41) do

  create_table "adv_ptf_release_maps", :force => true do |t|
    t.integer  "apar_defect_version_map_id", :null => false
    t.integer  "ptf_id",                     :null => false
    t.integer  "release_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adv_ptf_release_maps", ["apar_defect_version_map_id", "ptf_id", "release_id"], :name => "unique_adv_ptf_release_map_adv_ptf_release", :unique => true
  add_index "adv_ptf_release_maps", ["apar_defect_version_map_id"], :name => "adv_ptf_release_maps_apar_defect_version_map_idx"
  add_index "adv_ptf_release_maps", ["ptf_id"], :name => "adv_ptf_release_maps_ptf_idx"
  add_index "adv_ptf_release_maps", ["release_id"], :name => "adv_ptf_release_maps_release_idx"

  create_table "aix_files", :force => true do |t|
    t.string   "path",       :null => false
    t.string   "sha1",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aix_files", ["path", "sha1"], :name => "unique_aix_files_path", :unique => true

  create_table "apar_defect_version_maps", :force => true do |t|
    t.integer  "apar_id",    :null => false
    t.integer  "defect_id",  :null => false
    t.integer  "version_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apar_defect_version_maps", ["apar_id", "defect_id", "version_id"], :name => "unique_apar_defect_version_map_apar_defect_version", :unique => true
  add_index "apar_defect_version_maps", ["defect_id"], :name => "apar_defect_version_maps_defect_idx"
  add_index "apar_defect_version_maps", ["version_id"], :name => "apar_defect_version_maps_version_idx"

  create_table "apars", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "abstract"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apars", ["name"], :name => "unique_apar_name", :unique => true

  create_table "defects", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "defects", ["name"], :name => "unique_defect_name", :unique => true

  create_table "families", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "families", ["name"], :name => "unique_family_name", :unique => true

  create_table "fileset_aix_file_maps", :force => true do |t|
    t.integer  "fileset_id",  :null => false
    t.integer  "aix_file_id", :null => false
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

  add_index "fileset_ptf_maps", ["fileset_id", "ptf_id"], :name => "unique_fileset_ptf_map_fileset_ptf", :unique => true
  add_index "fileset_ptf_maps", ["ptf_id"], :name => "fileset_ptf_maps_ptf_idx"

  create_table "filesets", :force => true do |t|
    t.integer  "lpp_id",     :null => false
    t.string   "vrmf",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "filesets", ["lpp_id", "vrmf"], :name => "unique_fileset_lpp_id_vrmf", :unique => true

  create_table "image_paths", :force => true do |t|
    t.string   "path",       :null => false
    t.integer  "package_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_paths", ["path"], :name => "unique_image_path_path", :unique => true

  create_table "lpp_bases", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lpp_bases", ["name"], :name => "unique_lpp_base_name", :unique => true

  create_table "lpps", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "lpp_base_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lpps", ["lpp_base_id", "name"], :name => "unique_lpp_name", :unique => true

  create_table "package_fileset_maps", :force => true do |t|
    t.integer  "package_id", :null => false
    t.integer  "fileset_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "package_fileset_maps", ["fileset_id", "package_id"], :name => "unique_package_fileset_map_package_fileset", :unique => true

  create_table "packages", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "sha1",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packages", ["name", "sha1"], :name => "unique_package_name", :unique => true

  create_table "ptfs", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ptfs", ["name"], :name => "unique_ptf_name", :unique => true

  create_table "releases", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "family_id",  :null => false
    t.integer  "version_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "releases", ["family_id", "name"], :name => "unique_release_name_family_id", :unique => true

  create_table "service_pack_fileset_maps", :force => true do |t|
    t.integer  "service_pack_id", :null => false
    t.integer  "fileset_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_pack_fileset_maps", ["fileset_id", "service_pack_id"], :name => "unique_service_pack_fileset_map_service_pack_fileset", :unique => true
  add_index "service_pack_fileset_maps", ["fileset_id"], :name => "service_pack_fileset_maps_fileset_idx"

  create_table "service_packs", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_packs", ["name"], :name => "unique_service_pack_name", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["name"], :name => "unique_version_name", :unique => true

end
