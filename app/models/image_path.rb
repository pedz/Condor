# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class ImagePath < ActiveRecord::Base
  belongs_to :package

  def <=>(other)
    path <=> other.path
  end
end
