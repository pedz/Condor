class PgAttribute < ActiveRecord::Base
  set_table_name "pg_attribute"
  set_primary_key "oid"
  belongs_to :attrel, :class_name => "PgClass", :foreign_key => :attrelid
end
