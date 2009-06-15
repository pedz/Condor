class PtfsController < ApplicationController
  # GET /ptfs
  # GET /ptfs.xml
  def index
    @ptfs = Ptf.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptfs }
    end
  end

  # GET /ptfs/1
  # GET /ptfs/1.xml
  def show
    @ptf = Ptf.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ptf }
    end
  end

  # GET /ptfs/new
  # GET /ptfs/new.xml
#   def new
#     @ptf = Ptf.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @ptf }
#     end
#   end

  # GET /ptfs/1/edit
#   def edit
#     @ptf = Ptf.find(params[:id])
#   end

  # POST /ptfs
  # POST /ptfs.xml
#   def create
#     @ptf = Ptf.new(params[:ptf])

#     respond_to do |format|
#       if @ptf.save
#         flash[:notice] = 'Ptf was successfully created.'
#         format.html { redirect_to(@ptf) }
#         format.xml  { render :xml => @ptf, :status => :created, :location => @ptf }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @ptf.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /ptfs/1
  # PUT /ptfs/1.xml
#   def update
#     @ptf = Ptf.find(params[:id])

#     respond_to do |format|
#       if @ptf.update_attributes(params[:ptf])
#         flash[:notice] = 'Ptf was successfully updated.'
#         format.html { redirect_to(@ptf) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @ptf.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /ptfs/1
  # DELETE /ptfs/1.xml
#   def destroy
#     @ptf = Ptf.find(params[:id])
#     @ptf.destroy

#     respond_to do |format|
#       format.html { redirect_to(ptfs_url) }
#       format.xml  { head :ok }
#     end
#   end
end
