# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class AdvPtfReleaseMap < ActiveRecord::Base
  belongs_to :apar_defect_version_map
  belongs_to :ptf
  belongs_to :release
end
