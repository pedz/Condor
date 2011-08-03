# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class FilesetAixFileMap < ActiveRecord::Base
  belongs_to :fileset
  belongs_to :aix_file
end
