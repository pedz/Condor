# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class AixFile < ActiveRecord::Base
  has_many :fileset_aix_file_maps

  # Secondary Relationships
  has_many :filesets, :through => :fileset_aix_file_maps

  def <=>(other)
    path <=> other.path
  end
end
