class Fileset < ActiveRecord::Base
  belongs_to :lpp
  has_many   :fileset_ptf_maps
  has_many   :service_pack_fileset_map
  has_many   :package_fileset_maps
  has_many   :fileset_aix_file_maps
  has_many   :ptfapardefs

  # Secondary Relationships
  has_many :ptfs,          :through => :fileset_ptf_maps
  has_many :service_packs, :through => :service_pack_fileset_map
  has_many :packages,      :through => :package_fileset_maps
  has_many :aix_files,     :through => :fileset_aix_file_maps

  def <=>(other)
    if (temp = self.lpp <=> other.lpp) == 0
      self.vrmf <=> other.vrmf
    else
      temp
    end
  end

  def image_paths
    self.packages.map { |m| m.image_paths }.flatten
  end
end
