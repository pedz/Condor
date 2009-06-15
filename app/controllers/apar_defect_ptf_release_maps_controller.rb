class AparDefectPtfReleaseMapsController < ApplicationController
  # GET /apar_defect_ptf_release_maps
  # GET /apar_defect_ptf_release_maps.xml
  def index
    @apar_defect_ptf_release_maps = AparDefectPtfReleaseMaps.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apar_defect_ptf_release_maps }
    end
  end

  # GET /apar_defect_ptf_release_maps/1
  # GET /apar_defect_ptf_release_maps/1.xml
  def show
    @apar_defect_ptf_release_maps = AparDefectPtfReleaseMaps.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar_defect_ptf_release_maps }
    end
  end

  # GET /apar_defect_ptf_release_maps/new
  # GET /apar_defect_ptf_release_maps/new.xml
#   def new
#     @apar_defect_ptf_release_maps = AparDefectPtfReleaseMaps.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @apar_defect_ptf_release_maps }
#     end
#   end

  # GET /apar_defect_ptf_release_maps/1/edit
#   def edit
#     @apar_defect_ptf_release_maps = AparDefectPtfReleaseMaps.find(params[:id])
#   end

  # POST /apar_defect_ptf_release_maps
  # POST /apar_defect_ptf_release_maps.xml
#   def create
#     @apar_defect_ptf_release_maps = AparDefectPtfReleaseMaps.new(params[:apar_defect_ptf_release_maps])

#     respond_to do |format|
#       if @apar_defect_ptf_release_maps.save
#         flash[:notice] = 'AparDefectPtfReleaseMaps was successfully created.'
#         format.html { redirect_to(@apar_defect_ptf_release_maps) }
#         format.xml  { render :xml => @apar_defect_ptf_release_maps, :status => :created, :location => @apar_defect_ptf_release_maps }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @apar_defect_ptf_release_maps.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /apar_defect_ptf_release_maps/1
  # PUT /apar_defect_ptf_release_maps/1.xml
#   def update
#     @apar_defect_ptf_release_maps = AparDefectPtfReleaseMaps.find(params[:id])

#     respond_to do |format|
#       if @apar_defect_ptf_release_maps.update_attributes(params[:apar_defect_ptf_release_maps])
#         flash[:notice] = 'AparDefectPtfReleaseMaps was successfully updated.'
#         format.html { redirect_to(@apar_defect_ptf_release_maps) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @apar_defect_ptf_release_maps.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /apar_defect_ptf_release_maps/1
  # DELETE /apar_defect_ptf_release_maps/1.xml
#   def destroy
#     @apar_defect_ptf_release_maps = AparDefectPtfReleaseMaps.find(params[:id])
#     @apar_defect_ptf_release_maps.destroy

#     respond_to do |format|
#       format.html { redirect_to(apar_defect_ptf_release_maps_url) }
#       format.xml  { head :ok }
#     end
#   end
end
