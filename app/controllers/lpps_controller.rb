# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class LppsController < ApplicationController
  # GET /lpps
  # GET /lpps.xml
  def index
    @lpps = Lpp.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lpps }
    end
  end

  # GET /lpps/1
  # GET /lpps/1.xml
  def show
    @lpp = Lpp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lpp }
    end
  end

  # GET /lpps/new
  # GET /lpps/new.xml
#   def new
#     @lpp = Lpp.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @lpp }
#     end
#   end

  # GET /lpps/1/edit
#   def edit
#     @lpp = Lpp.find(params[:id])
#   end

  # POST /lpps
  # POST /lpps.xml
#   def create
#     @lpp = Lpp.new(params[:lpp])

#     respond_to do |format|
#       if @lpp.save
#         flash[:notice] = 'Lpp was successfully created.'
#         format.html { redirect_to(@lpp) }
#         format.xml  { render :xml => @lpp, :status => :created, :location => @lpp }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @lpp.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /lpps/1
  # PUT /lpps/1.xml
#   def update
#     @lpp = Lpp.find(params[:id])

#     respond_to do |format|
#       if @lpp.update_attributes(params[:lpp])
#         flash[:notice] = 'Lpp was successfully updated.'
#         format.html { redirect_to(@lpp) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @lpp.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /lpps/1
  # DELETE /lpps/1.xml
#   def destroy
#     @lpp = Lpp.find(params[:id])
#     @lpp.destroy

#     respond_to do |format|
#       format.html { redirect_to(lpps_url) }
#       format.xml  { head :ok }
#     end
#   end
end
