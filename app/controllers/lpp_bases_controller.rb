# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class LppBasesController < ApplicationController
  # GET /lpp_bases
  # GET /lpp_bases.xml
  def index
    @lpp_bases = LppBase.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lpp_bases }
    end
  end

  # GET /lpp_bases/1
  # GET /lpp_bases/1.xml
  def show
    @lpp_base = LppBase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lpp_base }
    end
  end

  # GET /lpp_bases/new
  # GET /lpp_bases/new.xml
#   def new
#     @lpp_base = LppBase.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @lpp_base }
#     end
#   end

  # GET /lpp_bases/1/edit
#   def edit
#     @lpp_base = LppBase.find(params[:id])
#   end

  # POST /lpp_bases
  # POST /lpp_bases.xml
#   def create
#     @lpp_base = LppBase.new(params[:lpp_base])

#     respond_to do |format|
#       if @lpp_base.save
#         flash[:notice] = 'LppBase was successfully created.'
#         format.html { redirect_to(@lpp_base) }
#         format.xml  { render :xml => @lpp_base, :status => :created, :location => @lpp_base }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @lpp_base.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /lpp_bases/1
  # PUT /lpp_bases/1.xml
#   def update
#     @lpp_base = LppBase.find(params[:id])

#     respond_to do |format|
#       if @lpp_base.update_attributes(params[:lpp_base])
#         flash[:notice] = 'LppBase was successfully updated.'
#         format.html { redirect_to(@lpp_base) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @lpp_base.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /lpp_bases/1
  # DELETE /lpp_bases/1.xml
#   def destroy
#     @lpp_base = LppBase.find(params[:id])
#     @lpp_base.destroy

#     respond_to do |format|
#       format.html { redirect_to(lpp_bases_url) }
#       format.xml  { head :ok }
#     end
#   end
end
