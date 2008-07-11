class AddPtfAparDefsView < ActiveRecord::Migration
  def self.up
    execute "CREATE OR REPLACE VIEW ptfapardefs (
               ptf, apar, defect, lpp_base, lpp, release, family, abstract, vrmf
             ) AS SELECT
               p.name, a.name, d.name, b.name, l.name, r.name, f.name,
               a.abstract, fs.vrmf
             FROM
               ptfs p, apars a, defects d, lpp_bases b, lpps l, releases r,
               families f, filesets fs, 
               apar_defect_ptf_release_maps adpr,
               fileset_ptf_maps f2p
             WHERE
               a.id = adpr.apar_id and
               d.id = adpr.defect_id and
               r.id = adpr.release_id and
               p.id = adpr.ptf_id and
               fs.id = f2p.fileset_id and
               p.id = f2p.ptf_id and
               fs.lpp_id = l.id and
               l.lpp_base_id = b.id and
               r.family_id = f.id;
             "
  end

  def self.down
    execute "DROP VIEW ptfapardefs"
  end
end
