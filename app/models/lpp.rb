# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class Lpp < ActiveRecord::Base
  belongs_to :lpp_base
  has_many :filesets

  def <=>(other)
    self.name <=> other.name
  end
end
