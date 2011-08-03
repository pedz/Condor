# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class FileChangesController < ApplicationController
  def show
    @file_changes = FileChange.find(params[:file])
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @file_changes }
    end
  end
end
