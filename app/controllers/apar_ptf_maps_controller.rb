class AparPtfMapsController < ApplicationController
  # GET /apar_ptf_maps
  # GET /apar_ptf_maps.xml
  def index
    @apar_ptf_maps = AparPtfMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apar_ptf_maps }
    end
  end

  # GET /apar_ptf_maps/1
  # GET /apar_ptf_maps/1.xml
  def show
    @apar_ptf_map = AparPtfMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar_ptf_map }
    end
  end

  # GET /apar_ptf_maps/new
  # GET /apar_ptf_maps/new.xml
  def new
    @apar_ptf_map = AparPtfMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @apar_ptf_map }
    end
  end

  # GET /apar_ptf_maps/1/edit
  def edit
    @apar_ptf_map = AparPtfMap.find(params[:id])
  end

  # POST /apar_ptf_maps
  # POST /apar_ptf_maps.xml
  def create
    @apar_ptf_map = AparPtfMap.new(params[:apar_ptf_map])

    respond_to do |format|
      if @apar_ptf_map.save
        flash[:notice] = 'AparPtfMap was successfully created.'
        format.html { redirect_to(@apar_ptf_map) }
        format.xml  { render :xml => @apar_ptf_map, :status => :created, :location => @apar_ptf_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @apar_ptf_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apar_ptf_maps/1
  # PUT /apar_ptf_maps/1.xml
  def update
    @apar_ptf_map = AparPtfMap.find(params[:id])

    respond_to do |format|
      if @apar_ptf_map.update_attributes(params[:apar_ptf_map])
        flash[:notice] = 'AparPtfMap was successfully updated.'
        format.html { redirect_to(@apar_ptf_map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @apar_ptf_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apar_ptf_maps/1
  # DELETE /apar_ptf_maps/1.xml
  def destroy
    @apar_ptf_map = AparPtfMap.find(params[:id])
    @apar_ptf_map.destroy

    respond_to do |format|
      format.html { redirect_to(apar_ptf_maps_url) }
      format.xml  { head :ok }
    end
  end
end
