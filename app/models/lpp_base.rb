# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class LppBase < ActiveRecord::Base
  has_many :lpps

  def <=>(other)
    self.name <=> other.name
  end
end
