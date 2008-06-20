class ImagePathFilesetMapsController < ApplicationController
  # GET /image_path_fileset_maps
  # GET /image_path_fileset_maps.xml
  def index
    @image_path_fileset_maps = ImagePathFilesetMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @image_path_fileset_maps }
    end
  end

  # GET /image_path_fileset_maps/1
  # GET /image_path_fileset_maps/1.xml
  def show
    @image_path_fileset_map = ImagePathFilesetMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image_path_fileset_map }
    end
  end

  # GET /image_path_fileset_maps/new
  # GET /image_path_fileset_maps/new.xml
  def new
    @image_path_fileset_map = ImagePathFilesetMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image_path_fileset_map }
    end
  end

  # GET /image_path_fileset_maps/1/edit
  def edit
    @image_path_fileset_map = ImagePathFilesetMap.find(params[:id])
  end

  # POST /image_path_fileset_maps
  # POST /image_path_fileset_maps.xml
  def create
    @image_path_fileset_map = ImagePathFilesetMap.new(params[:image_path_fileset_map])

    respond_to do |format|
      if @image_path_fileset_map.save
        flash[:notice] = 'ImagePathFilesetMap was successfully created.'
        format.html { redirect_to(@image_path_fileset_map) }
        format.xml  { render :xml => @image_path_fileset_map, :status => :created, :location => @image_path_fileset_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image_path_fileset_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /image_path_fileset_maps/1
  # PUT /image_path_fileset_maps/1.xml
  def update
    @image_path_fileset_map = ImagePathFilesetMap.find(params[:id])

    respond_to do |format|
      if @image_path_fileset_map.update_attributes(params[:image_path_fileset_map])
        flash[:notice] = 'ImagePathFilesetMap was successfully updated.'
        format.html { redirect_to(@image_path_fileset_map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image_path_fileset_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /image_path_fileset_maps/1
  # DELETE /image_path_fileset_maps/1.xml
  def destroy
    @image_path_fileset_map = ImagePathFilesetMap.find(params[:id])
    @image_path_fileset_map.destroy

    respond_to do |format|
      format.html { redirect_to(image_path_fileset_maps_url) }
      format.xml  { head :ok }
    end
  end
end
