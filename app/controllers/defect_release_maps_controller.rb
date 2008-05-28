class DefectReleaseMapsController < ApplicationController
  # GET /defect_release_maps
  # GET /defect_release_maps.xml
  def index
    @defect_release_maps = DefectReleaseMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @defect_release_maps }
    end
  end

  # GET /defect_release_maps/1
  # GET /defect_release_maps/1.xml
  def show
    @defect_release_map = DefectReleaseMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @defect_release_map }
    end
  end

  # GET /defect_release_maps/new
  # GET /defect_release_maps/new.xml
  def new
    @defect_release_map = DefectReleaseMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @defect_release_map }
    end
  end

  # GET /defect_release_maps/1/edit
  def edit
    @defect_release_map = DefectReleaseMap.find(params[:id])
  end

  # POST /defect_release_maps
  # POST /defect_release_maps.xml
  def create
    @defect_release_map = DefectReleaseMap.new(params[:defect_release_map])

    respond_to do |format|
      if @defect_release_map.save
        flash[:notice] = 'DefectReleaseMap was successfully created.'
        format.html { redirect_to(@defect_release_map) }
        format.xml  { render :xml => @defect_release_map, :status => :created, :location => @defect_release_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @defect_release_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /defect_release_maps/1
  # PUT /defect_release_maps/1.xml
  def update
    @defect_release_map = DefectReleaseMap.find(params[:id])

    respond_to do |format|
      if @defect_release_map.update_attributes(params[:defect_release_map])
        flash[:notice] = 'DefectReleaseMap was successfully updated.'
        format.html { redirect_to(@defect_release_map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @defect_release_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /defect_release_maps/1
  # DELETE /defect_release_maps/1.xml
  def destroy
    @defect_release_map = DefectReleaseMap.find(params[:id])
    @defect_release_map.destroy

    respond_to do |format|
      format.html { redirect_to(defect_release_maps_url) }
      format.xml  { head :ok }
    end
  end
end
