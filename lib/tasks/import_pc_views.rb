#!/usr/bin/env script/runner

GOOD_FAMILY = Regexp.new("aix")
GOOD_PRODUCT = Regexp.new("^(5[234].|6..)$")

nby_ptf = Ptf.find(:first, :conditions => { :name => "Not Built Yet" })
nby_release = Release.find(:first, :conditions => { :name => "Not Built Yet" })

def create_map(maps, hash, ptf)
  unless maps.detect { |m| m.ptf && m.ptf.id == ptf.id }
    hash[:ptf_id] = ptf.id
    hash[:release_id] = nby_release.id
    AparDefectPtfReleaseMap.create(hash)
  end
end

File.open(ARGV[0]) do |file|
  Apar.transaction do
    file.each_line do |line|
      line.chomp!
      defect, owner, family, product, state, apar_state, apar, ptfs = line.split('|')
      next unless GOOD_FAMILY.match(family)
      next unless GOOD_PRODUCT.match(product)
      defect = Defect.find_or_create_by_name defect
      apar = Apar.find_or_create_by_name apar

      hash = {
        :apar_id => apar.id,
        :defect_id => defect.id
      }

      maps = AparDefectPtfReleaseMap.find(:all, :conditions => hash)

      if ptfs.nil?
        create_map(maps, hash, nby_ptf)
      else
        ptfs.split(', ').each do |ptf|
          ptf = Ptf.find_or_create_by_name ptf
          create_map(maps, hash, ptf)
        end
      end
    end
  end
end
