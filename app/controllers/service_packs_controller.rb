# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class ServicePacksController < ApplicationController
  # GET /service_packs
  # GET /service_packs.xml
  def index
    @service_packs = ServicePack.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @service_packs }
    end
  end

  # GET /service_packs/1
  # GET /service_packs/1.xml
  def show
    @service_pack = ServicePack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service_pack }
    end
  end

  # GET /service_packs/new
  # GET /service_packs/new.xml
#   def new
#     @service_pack = ServicePack.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @service_pack }
#     end
#   end

  # GET /service_packs/1/edit
#   def edit
#     @service_pack = ServicePack.find(params[:id])
#   end

  # POST /service_packs
  # POST /service_packs.xml
#   def create
#     @service_pack = ServicePack.new(params[:service_pack])

#     respond_to do |format|
#       if @service_pack.save
#         flash[:notice] = 'ServicePack was successfully created.'
#         format.html { redirect_to(@service_pack) }
#         format.xml  { render :xml => @service_pack, :status => :created, :location => @service_pack }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @service_pack.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /service_packs/1
  # PUT /service_packs/1.xml
#   def update
#     @service_pack = ServicePack.find(params[:id])

#     respond_to do |format|
#       if @service_pack.update_attributes(params[:service_pack])
#         flash[:notice] = 'ServicePack was successfully updated.'
#         format.html { redirect_to(@service_pack) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @service_pack.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /service_packs/1
  # DELETE /service_packs/1.xml
#   def destroy
#     @service_pack = ServicePack.find(params[:id])
#     @service_pack.destroy

#     respond_to do |format|
#       format.html { redirect_to(service_packs_url) }
#       format.xml  { head :ok }
#     end
#   end
end
