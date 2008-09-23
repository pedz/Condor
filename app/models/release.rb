class Release < ActiveRecord::Base
  belongs_to :family
  has_many   :apar_defect_ptf_release_maps
  
  # Secondary relations
  has_many :apars,   :through => :apar_defect_ptf_release_maps
  has_many :defects, :through => :apar_defect_ptf_release_maps
  has_many :ptfs,    :through => :apar_defect_ptf_release_maps

  def <=>(other)
    self.name <=> other.name
  end
end
