class PgConstraint < ActiveRecord::Base
  set_table_name "pg_constraint"
  set_primary_key "oid"
  belongs_to :conrel, :class_name => "PgClass", :foreign_key => :conrelid
end
