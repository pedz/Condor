# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class PackageFilesetMap < ActiveRecord::Base
  belongs_to :package
  belongs_to :fileset
end
