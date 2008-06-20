class ImagePathsController < ApplicationController
  # GET /image_paths
  # GET /image_paths.xml
  def index
    @image_paths = ImagePath.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @image_paths }
    end
  end

  # GET /image_paths/1
  # GET /image_paths/1.xml
  def show
    @image_path = ImagePath.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image_path }
    end
  end

  # GET /image_paths/new
  # GET /image_paths/new.xml
  def new
    @image_path = ImagePath.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image_path }
    end
  end

  # GET /image_paths/1/edit
  def edit
    @image_path = ImagePath.find(params[:id])
  end

  # POST /image_paths
  # POST /image_paths.xml
  def create
    @image_path = ImagePath.new(params[:image_path])

    respond_to do |format|
      if @image_path.save
        flash[:notice] = 'ImagePath was successfully created.'
        format.html { redirect_to(@image_path) }
        format.xml  { render :xml => @image_path, :status => :created, :location => @image_path }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image_path.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /image_paths/1
  # PUT /image_paths/1.xml
  def update
    @image_path = ImagePath.find(params[:id])

    respond_to do |format|
      if @image_path.update_attributes(params[:image_path])
        flash[:notice] = 'ImagePath was successfully updated.'
        format.html { redirect_to(@image_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image_path.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /image_paths/1
  # DELETE /image_paths/1.xml
  def destroy
    @image_path = ImagePath.find(params[:id])
    @image_path.destroy

    respond_to do |format|
      format.html { redirect_to(image_paths_url) }
      format.xml  { head :ok }
    end
  end
end
