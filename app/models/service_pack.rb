# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class ServicePack < ActiveRecord::Base
  has_many :service_pack_fileset_map

  # Secondary Relationships
  has_many :filesets, :through => :service_pack_fileset_map
end
