class AddShippedFilesView < ActiveRecord::Migration
  def self.up
    execute "CREATE OR REPLACE VIEW shipped_files (
             image,    image_id,
             package,  package_id,
             lpp,      lpp_id,
             vrmf,     fileset_id,
             aix_file, aix_file_id
           ) AS SELECT
             ip.path,  ip.id,
             p.name,   p.id,
             lpp.name, lpp.id,
             fs.vrmf,  fs.id,
             af.path,  af.id
           FROM
             image_paths ip,
             packages p,
             image_path_package_maps ippm,
             lpps lpp,
             filesets fs,
             package_fileset_maps pfm,
             image_path_fileset_maps ipfm,
             aix_files af,
             fileset_aix_file_maps fafm
           WHERE
             ip.id = ippm.image_path_id AND
             p.id = ippm.package_id AND
             fs.lpp_id = lpp.id AND
             pfm.package_id = p.id AND
             pfm.fileset_id = fs.id AND
             ipfm.image_path_id = ip.id AND
             ipfm.fileset_id = fs.id AND
             fafm.fileset_id = fs.id AND
             fafm.aix_file_id = af.id;"
  end

  def self.down
    execute "DROP VIEW shipped_files"
  end
end
