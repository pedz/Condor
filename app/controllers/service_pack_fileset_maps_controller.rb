class ServicePackFilesetMapsController < ApplicationController
  # GET /service_pack_fileset_maps
  # GET /service_pack_fileset_maps.xml
  def index
    @service_pack_fileset_maps = ServicePackFilesetMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @service_pack_fileset_maps }
    end
  end

  # GET /service_pack_fileset_maps/1
  # GET /service_pack_fileset_maps/1.xml
  def show
    @service_pack_fileset_map = ServicePackFilesetMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service_pack_fileset_map }
    end
  end

  # GET /service_pack_fileset_maps/new
  # GET /service_pack_fileset_maps/new.xml
  def new
    @service_pack_fileset_map = ServicePackFilesetMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service_pack_fileset_map }
    end
  end

  # GET /service_pack_fileset_maps/1/edit
  def edit
    @service_pack_fileset_map = ServicePackFilesetMap.find(params[:id])
  end

  # POST /service_pack_fileset_maps
  # POST /service_pack_fileset_maps.xml
  def create
    @service_pack_fileset_map = ServicePackFilesetMap.new(params[:service_pack_fileset_map])

    respond_to do |format|
      if @service_pack_fileset_map.save
        flash[:notice] = 'ServicePackFilesetMap was successfully created.'
        format.html { redirect_to(@service_pack_fileset_map) }
        format.xml  { render :xml => @service_pack_fileset_map, :status => :created, :location => @service_pack_fileset_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_pack_fileset_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /service_pack_fileset_maps/1
  # PUT /service_pack_fileset_maps/1.xml
  def update
    @service_pack_fileset_map = ServicePackFilesetMap.find(params[:id])

    respond_to do |format|
      if @service_pack_fileset_map.update_attributes(params[:service_pack_fileset_map])
        flash[:notice] = 'ServicePackFilesetMap was successfully updated.'
        format.html { redirect_to(@service_pack_fileset_map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service_pack_fileset_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /service_pack_fileset_maps/1
  # DELETE /service_pack_fileset_maps/1.xml
  def destroy
    @service_pack_fileset_map = ServicePackFilesetMap.find(params[:id])
    @service_pack_fileset_map.destroy

    respond_to do |format|
      format.html { redirect_to(service_pack_fileset_maps_url) }
      format.xml  { head :ok }
    end
  end
end
