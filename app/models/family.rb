# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class Family < ActiveRecord::Base
  has_many :releases

  def <=>(other)
    self.name <=> other.name
  end
end
