class FilesetAixFileMapsController < ApplicationController
  # GET /fileset_aix_file_maps
  # GET /fileset_aix_file_maps.xml
  def index
    @fileset_aix_file_maps = FilesetAixFileMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fileset_aix_file_maps }
    end
  end

  # GET /fileset_aix_file_maps/1
  # GET /fileset_aix_file_maps/1.xml
  def show
    @fileset_aix_file_map = FilesetAixFileMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fileset_aix_file_map }
    end
  end

  # GET /fileset_aix_file_maps/new
  # GET /fileset_aix_file_maps/new.xml
#   def new
#     @fileset_aix_file_map = FilesetAixFileMap.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @fileset_aix_file_map }
#     end
#   end

  # GET /fileset_aix_file_maps/1/edit
#   def edit
#     @fileset_aix_file_map = FilesetAixFileMap.find(params[:id])
#   end

  # POST /fileset_aix_file_maps
  # POST /fileset_aix_file_maps.xml
#   def create
#     @fileset_aix_file_map = FilesetAixFileMap.new(params[:fileset_aix_file_map])

#     respond_to do |format|
#       if @fileset_aix_file_map.save
#         flash[:notice] = 'FilesetAixFileMap was successfully created.'
#         format.html { redirect_to(@fileset_aix_file_map) }
#         format.xml  { render :xml => @fileset_aix_file_map, :status => :created, :location => @fileset_aix_file_map }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @fileset_aix_file_map.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /fileset_aix_file_maps/1
  # PUT /fileset_aix_file_maps/1.xml
#   def update
#     @fileset_aix_file_map = FilesetAixFileMap.find(params[:id])

#     respond_to do |format|
#       if @fileset_aix_file_map.update_attributes(params[:fileset_aix_file_map])
#         flash[:notice] = 'FilesetAixFileMap was successfully updated.'
#         format.html { redirect_to(@fileset_aix_file_map) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @fileset_aix_file_map.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /fileset_aix_file_maps/1
  # DELETE /fileset_aix_file_maps/1.xml
#   def destroy
#     @fileset_aix_file_map = FilesetAixFileMap.find(params[:id])
#     @fileset_aix_file_map.destroy

#     respond_to do |format|
#       format.html { redirect_to(fileset_aix_file_maps_url) }
#       format.xml  { head :ok }
#     end
#   end
end
