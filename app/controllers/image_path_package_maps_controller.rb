class ImagePathPackageMapsController < ApplicationController
  # GET /image_path_package_maps
  # GET /image_path_package_maps.xml
  def index
    @image_path_package_maps = ImagePathPackageMap.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @image_path_package_maps }
    end
  end

  # GET /image_path_package_maps/1
  # GET /image_path_package_maps/1.xml
  def show
    @image_path_package_map = ImagePathPackageMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image_path_package_map }
    end
  end

  # GET /image_path_package_maps/new
  # GET /image_path_package_maps/new.xml
#   def new
#     @image_path_package_map = ImagePathPackageMap.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @image_path_package_map }
#     end
#   end

  # GET /image_path_package_maps/1/edit
#   def edit
#     @image_path_package_map = ImagePathPackageMap.find(params[:id])
#   end

  # POST /image_path_package_maps
  # POST /image_path_package_maps.xml
#   def create
#     @image_path_package_map = ImagePathPackageMap.new(params[:image_path_package_map])

#     respond_to do |format|
#       if @image_path_package_map.save
#         flash[:notice] = 'ImagePathPackageMap was successfully created.'
#         format.html { redirect_to(@image_path_package_map) }
#         format.xml  { render :xml => @image_path_package_map, :status => :created, :location => @image_path_package_map }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @image_path_package_map.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /image_path_package_maps/1
  # PUT /image_path_package_maps/1.xml
#   def update
#     @image_path_package_map = ImagePathPackageMap.find(params[:id])

#     respond_to do |format|
#       if @image_path_package_map.update_attributes(params[:image_path_package_map])
#         flash[:notice] = 'ImagePathPackageMap was successfully updated.'
#         format.html { redirect_to(@image_path_package_map) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @image_path_package_map.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /image_path_package_maps/1
  # DELETE /image_path_package_maps/1.xml
#   def destroy
#     @image_path_package_map = ImagePathPackageMap.find(params[:id])
#     @image_path_package_map.destroy

#     respond_to do |format|
#       format.html { redirect_to(image_path_package_maps_url) }
#       format.xml  { head :ok }
#     end
#   end
end
