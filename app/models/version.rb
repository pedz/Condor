# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class Version < ActiveRecord::Base
  has_many :releases
  has_many :apar_defect_version_maps
  has_many :upd_pc_views
  
  # Secondary relations
  has_many :defects,  :through => :apar_defect_version_maps
  has_many :ptfs,     :through => :apar_defect_version_maps
  has_many :versions, :through => :apar_defect_version_maps

  def <=>(other)
    self.name <=> other.name
  end
end
