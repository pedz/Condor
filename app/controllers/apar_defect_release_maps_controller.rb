class AparDefectReleaseMapsController < ApplicationController
  # GET /apar_defect_release_maps
  # GET /apar_defect_release_maps.xml
  def index
    @apar_defect_release_maps = AparDefectReleaseMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apar_defect_release_maps }
    end
  end

  # GET /apar_defect_release_maps/1
  # GET /apar_defect_release_maps/1.xml
  def show
    @apar_defect_release_map = AparDefectReleaseMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar_defect_release_map }
    end
  end

  # GET /apar_defect_release_maps/new
  # GET /apar_defect_release_maps/new.xml
  def new
    @apar_defect_release_map = AparDefectReleaseMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @apar_defect_release_map }
    end
  end

  # GET /apar_defect_release_maps/1/edit
  def edit
    @apar_defect_release_map = AparDefectReleaseMap.find(params[:id])
  end

  # POST /apar_defect_release_maps
  # POST /apar_defect_release_maps.xml
  def create
    @apar_defect_release_map = AparDefectReleaseMap.new(params[:apar_defect_release_map])

    respond_to do |format|
      if @apar_defect_release_map.save
        flash[:notice] = 'AparDefectReleaseMap was successfully created.'
        format.html { redirect_to(@apar_defect_release_map) }
        format.xml  { render :xml => @apar_defect_release_map, :status => :created, :location => @apar_defect_release_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @apar_defect_release_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apar_defect_release_maps/1
  # PUT /apar_defect_release_maps/1.xml
  def update
    @apar_defect_release_map = AparDefectReleaseMap.find(params[:id])

    respond_to do |format|
      if @apar_defect_release_map.update_attributes(params[:apar_defect_release_map])
        flash[:notice] = 'AparDefectReleaseMap was successfully updated.'
        format.html { redirect_to(@apar_defect_release_map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @apar_defect_release_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apar_defect_release_maps/1
  # DELETE /apar_defect_release_maps/1.xml
  def destroy
    @apar_defect_release_map = AparDefectReleaseMap.find(params[:id])
    @apar_defect_release_map.destroy

    respond_to do |format|
      format.html { redirect_to(apar_defect_release_maps_url) }
      format.xml  { head :ok }
    end
  end
end
