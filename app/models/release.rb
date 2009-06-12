class Release < ActiveRecord::Base
  belongs_to :family
  belongs_to :version
  has_many   :adv_ptf_release_maps
  
  # Secondary relations
  has_many :apars,    :through => :adv_ptf_release_maps
  has_many :defects,  :through => :adv_ptf_release_maps
  has_many :versions, :through => :adv_ptf_release_maps

  def <=>(other)
    self.name <=> other.name
  end
end
