# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class ShippedFilesController < ApplicationController
  def show
    @shipped_files = ShippedFile.find(:all, :conditions => { :aix_file_sha1 => params[:sha1]})
  end
end
