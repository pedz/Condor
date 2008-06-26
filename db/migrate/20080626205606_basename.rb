class Basename < ActiveRecord::Migration
  def self.up
    execute <<EOF
CREATE OR REPLACE FUNCTION basename(text) RETURNS text AS $$
    SELECT regexp_replace($1, E'^.*/([^/.]*)(\\..*)?$', E'\\1')
$$ LANGUAGE SQL IMMUTABLE STRICT;
EOF
  end

  def self.down
    execute "DROP FUNCTION basename(text);"
  end
end
