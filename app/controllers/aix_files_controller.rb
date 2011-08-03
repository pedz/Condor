# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class AixFilesController < ApplicationController
  # GET /aix_files
  # GET /aix_files.xml
  def index
    @aix_files = AixFile.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @aix_files }
    end
  end

  # GET /aix_files/1
  # GET /aix_files/1.xml
  def show
    @aix_file = AixFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aix_file }
    end
  end

  # GET /aix_files/new
  # GET /aix_files/new.xml
#   def new
#     @aix_file = AixFile.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @aix_file }
#     end
#   end

  # GET /aix_files/1/edit
#   def edit
#     @aix_file = AixFile.find(params[:id])
#   end

  # POST /aix_files
  # POST /aix_files.xml
#   def create
#     @aix_file = AixFile.new(params[:aix_file])

#     respond_to do |format|
#       if @aix_file.save
#         flash[:notice] = 'AixFile was successfully created.'
#         format.html { redirect_to(@aix_file) }
#         format.xml  { render :xml => @aix_file, :status => :created, :location => @aix_file }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @aix_file.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /aix_files/1
  # PUT /aix_files/1.xml
#   def update
#     @aix_file = AixFile.find(params[:id])

#     respond_to do |format|
#       if @aix_file.update_attributes(params[:aix_file])
#         flash[:notice] = 'AixFile was successfully updated.'
#         format.html { redirect_to(@aix_file) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @aix_file.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /aix_files/1
  # DELETE /aix_files/1.xml
#   def destroy
#     @aix_file = AixFile.find(params[:id])
#     @aix_file.destroy

#     respond_to do |format|
#       format.html { redirect_to(aix_files_url) }
#       format.xml  { head :ok }
#     end
#   end
end
