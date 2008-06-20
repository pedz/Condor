class PackageFilesetMapsController < ApplicationController
  # GET /package_fileset_maps
  # GET /package_fileset_maps.xml
  def index
    @package_fileset_maps = PackageFilesetMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @package_fileset_maps }
    end
  end

  # GET /package_fileset_maps/1
  # GET /package_fileset_maps/1.xml
  def show
    @package_fileset_map = PackageFilesetMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @package_fileset_map }
    end
  end

  # GET /package_fileset_maps/new
  # GET /package_fileset_maps/new.xml
  def new
    @package_fileset_map = PackageFilesetMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @package_fileset_map }
    end
  end

  # GET /package_fileset_maps/1/edit
  def edit
    @package_fileset_map = PackageFilesetMap.find(params[:id])
  end

  # POST /package_fileset_maps
  # POST /package_fileset_maps.xml
  def create
    @package_fileset_map = PackageFilesetMap.new(params[:package_fileset_map])

    respond_to do |format|
      if @package_fileset_map.save
        flash[:notice] = 'PackageFilesetMap was successfully created.'
        format.html { redirect_to(@package_fileset_map) }
        format.xml  { render :xml => @package_fileset_map, :status => :created, :location => @package_fileset_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @package_fileset_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /package_fileset_maps/1
  # PUT /package_fileset_maps/1.xml
  def update
    @package_fileset_map = PackageFilesetMap.find(params[:id])

    respond_to do |format|
      if @package_fileset_map.update_attributes(params[:package_fileset_map])
        flash[:notice] = 'PackageFilesetMap was successfully updated.'
        format.html { redirect_to(@package_fileset_map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @package_fileset_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /package_fileset_maps/1
  # DELETE /package_fileset_maps/1.xml
  def destroy
    @package_fileset_map = PackageFilesetMap.find(params[:id])
    @package_fileset_map.destroy

    respond_to do |format|
      format.html { redirect_to(package_fileset_maps_url) }
      format.xml  { head :ok }
    end
  end
end
