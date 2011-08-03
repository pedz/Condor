# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class AparDefectVersionMap < ActiveRecord::Base
  belongs_to :apar
  belongs_to :defect
  belongs_to :version
  has_many   :adv_ptf_release_maps

  # Secondary Relations
  has_many   :ptfs,     :through => :adv_ptf_release_maps
  has_many   :releases, :through => :adv_ptf_release_maps
end
