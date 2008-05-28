class FilesetPtfMapsController < ApplicationController
  # GET /fileset_ptf_maps
  # GET /fileset_ptf_maps.xml
  def index
    @fileset_ptf_maps = FilesetPtfMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fileset_ptf_maps }
    end
  end

  # GET /fileset_ptf_maps/1
  # GET /fileset_ptf_maps/1.xml
  def show
    @fileset_ptf_map = FilesetPtfMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fileset_ptf_map }
    end
  end

  # GET /fileset_ptf_maps/new
  # GET /fileset_ptf_maps/new.xml
  def new
    @fileset_ptf_map = FilesetPtfMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fileset_ptf_map }
    end
  end

  # GET /fileset_ptf_maps/1/edit
  def edit
    @fileset_ptf_map = FilesetPtfMap.find(params[:id])
  end

  # POST /fileset_ptf_maps
  # POST /fileset_ptf_maps.xml
  def create
    @fileset_ptf_map = FilesetPtfMap.new(params[:fileset_ptf_map])

    respond_to do |format|
      if @fileset_ptf_map.save
        flash[:notice] = 'FilesetPtfMap was successfully created.'
        format.html { redirect_to(@fileset_ptf_map) }
        format.xml  { render :xml => @fileset_ptf_map, :status => :created, :location => @fileset_ptf_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fileset_ptf_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fileset_ptf_maps/1
  # PUT /fileset_ptf_maps/1.xml
  def update
    @fileset_ptf_map = FilesetPtfMap.find(params[:id])

    respond_to do |format|
      if @fileset_ptf_map.update_attributes(params[:fileset_ptf_map])
        flash[:notice] = 'FilesetPtfMap was successfully updated.'
        format.html { redirect_to(@fileset_ptf_map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fileset_ptf_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fileset_ptf_maps/1
  # DELETE /fileset_ptf_maps/1.xml
  def destroy
    @fileset_ptf_map = FilesetPtfMap.find(params[:id])
    @fileset_ptf_map.destroy

    respond_to do |format|
      format.html { redirect_to(fileset_ptf_maps_url) }
      format.xml  { head :ok }
    end
  end
end
