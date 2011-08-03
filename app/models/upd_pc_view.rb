# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class UpdPcView < ActiveRecord::Base
  belongs_to :ptf
  belongs_to :fileset
  belongs_to :defect
  belongs_to :version
end
