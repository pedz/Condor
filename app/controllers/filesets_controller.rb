class FilesetsController < ApplicationController
  # GET /filesets
  # GET /filesets.xml
  def index
    @filesets = Fileset.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @filesets }
    end
  end

  # GET /filesets/1
  # GET /filesets/1.xml
  def show
    @fileset = Fileset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fileset }
    end
  end

  # GET /filesets/new
  # GET /filesets/new.xml
#   def new
#     @fileset = Fileset.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @fileset }
#     end
#   end

  # GET /filesets/1/edit
#   def edit
#     @fileset = Fileset.find(params[:id])
#   end

  # POST /filesets
  # POST /filesets.xml
#   def create
#     @fileset = Fileset.new(params[:fileset])

#     respond_to do |format|
#       if @fileset.save
#         flash[:notice] = 'Fileset was successfully created.'
#         format.html { redirect_to(@fileset) }
#         format.xml  { render :xml => @fileset, :status => :created, :location => @fileset }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @fileset.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /filesets/1
  # PUT /filesets/1.xml
#   def update
#     @fileset = Fileset.find(params[:id])

#     respond_to do |format|
#       if @fileset.update_attributes(params[:fileset])
#         flash[:notice] = 'Fileset was successfully updated.'
#         format.html { redirect_to(@fileset) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @fileset.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /filesets/1
  # DELETE /filesets/1.xml
#   def destroy
#     @fileset = Fileset.find(params[:id])
#     @fileset.destroy

#     respond_to do |format|
#       format.html { redirect_to(filesets_url) }
#       format.xml  { head :ok }
#     end
#   end
end
