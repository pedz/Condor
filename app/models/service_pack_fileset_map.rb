# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class ServicePackFilesetMap < ActiveRecord::Base
  belongs_to :service_pack
  belongs_to :fileset
end
