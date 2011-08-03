# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class PtfAparDefsController < ApplicationController
  def show
    @ptfapardefs = Ptfapardef.find(:all,
                                   :conditions => { :defect => params[:id]},
                                   :select => "distinct ptf, apar, defect")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar }
    end
  end
end
