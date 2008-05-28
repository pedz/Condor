class AparDefectMapsController < ApplicationController
  # GET /apar_defect_maps
  # GET /apar_defect_maps.xml
  def index
    @apar_defect_maps = AparDefectMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apar_defect_maps }
    end
  end

  # GET /apar_defect_maps/1
  # GET /apar_defect_maps/1.xml
  def show
    @apar_defect_map = AparDefectMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar_defect_map }
    end
  end

  # GET /apar_defect_maps/new
  # GET /apar_defect_maps/new.xml
  def new
    @apar_defect_map = AparDefectMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @apar_defect_map }
    end
  end

  # GET /apar_defect_maps/1/edit
  def edit
    @apar_defect_map = AparDefectMap.find(params[:id])
  end

  # POST /apar_defect_maps
  # POST /apar_defect_maps.xml
  def create
    @apar_defect_map = AparDefectMap.new(params[:apar_defect_map])

    respond_to do |format|
      if @apar_defect_map.save
        flash[:notice] = 'AparDefectMap was successfully created.'
        format.html { redirect_to(@apar_defect_map) }
        format.xml  { render :xml => @apar_defect_map, :status => :created, :location => @apar_defect_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @apar_defect_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apar_defect_maps/1
  # PUT /apar_defect_maps/1.xml
  def update
    @apar_defect_map = AparDefectMap.find(params[:id])

    respond_to do |format|
      if @apar_defect_map.update_attributes(params[:apar_defect_map])
        flash[:notice] = 'AparDefectMap was successfully updated.'
        format.html { redirect_to(@apar_defect_map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @apar_defect_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apar_defect_maps/1
  # DELETE /apar_defect_maps/1.xml
  def destroy
    @apar_defect_map = AparDefectMap.find(params[:id])
    @apar_defect_map.destroy

    respond_to do |format|
      format.html { redirect_to(apar_defect_maps_url) }
      format.xml  { head :ok }
    end
  end
end
