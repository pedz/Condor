# This view essentially replicates the ptfapardef records.
class AddPtfAparDefsView < ActiveRecord::Migration
  def self.up
    execute "CREATE OR REPLACE VIEW ptfapardefs (
               ptf, apar, defect, lpp_base, lpp, release, family, abstract, vrmf,
               apar_id,
               defect_id,
               family_id,
               fileset_id,
               lpp_base_id,
               lpp_id,
               ptf_id,
               release_id
             ) AS SELECT
               p.name, a.name, d.name, b.name, l.name, r.name, f.name, a.abstract, fs.vrmf,
               a.id,
               d.id,
               f.id,
               fs.id, 
               b.id,
               l.id,
               p.id,
               r.id
             FROM
               apar_defect_version_maps adv,
               adv_ptf_release_maps apr,
               apars a,
               defects d,
               families f,
               fileset_ptf_maps f2p,
               filesets fs, 
               lpp_bases b,
               lpps l,
               ptfs p,
               releases r
             WHERE
               a.id = adv.apar_id and
               d.id = adv.defect_id and
               adv.id = apr.apar_defect_version_map_id and
               r.id = apr.release_id and
               p.id = apr.ptf_id and
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
