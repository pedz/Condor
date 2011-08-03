# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class Package < ActiveRecord::Base
  has_many :image_paths
  has_many :package_fileset_maps

  # Secondary Relationships
  has_many :filesets, :through => :package_fileset_maps

  def <=>(other)
    self.name <=> other.name
  end
end
