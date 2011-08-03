# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class ChangesController < ApplicationController
  def show
    @changes = Change.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @changes }
    end
  end
end
