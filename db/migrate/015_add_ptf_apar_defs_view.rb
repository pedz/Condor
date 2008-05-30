class AddPtfAparDefsView < ActiveRecord::Migration
  def self.up
    execute "CREATE OR REPLACE VIEW ptfapardefs (
               ptf, apar, defect, base, lpp, release, family, abstract, vrmf
             ) AS SELECT
               p.name, a.name, d.name, b.name, l.name, r.name, f.name,
               a.abstract, fs.vrmf
             FROM
               ptfs p, apars a, defects d, bases b, lpps l, releases r,
               families f, filesets fs, 
               apar_defect_maps a2d, apar_ptf_maps a2p, defect_release_maps d2r,
               fileset_ptf_maps f2p
             WHERE
               a.id = a2d.apar_id and
               d.id = a2d.defect_id and
               a.id = a2p.apar_id and
               p.id = a2p.ptf_id and
               d.id = d2r.defect_id and
               r.id = d2r.release_id and
               fs.id = f2p.fileset_id and
               p.id = f2p.ptf_id and
               fs.lpp_id = l.id and
               l.base_id = b.id and
               r.family_id = f.id;
             "
  end

  def self.down
    execute "DROP VIEW ptfapardefs"
  end
end
