class PgClass < ActiveRecord::Base
  set_table_name "pg_class"
  set_primary_key "oid"
  # has_many :constraints, 
  # has_many :attributes, :class_name => "PgAttribute", :foreign_key => :attrelid
end
