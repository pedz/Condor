class AparsController < ApplicationController
  # GET /apars
  # GET /apars.xml
  def index
    @apars = Apar.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apars }
    end
  end

  # GET /apars/1
  # GET /apars/1.xml
  def show
    @apar = Apar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar }
    end
  end

  # GET /apars/new
  # GET /apars/new.xml
#   def new
#     @apar = Apar.new

#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @apar }
#     end
#   end

  # GET /apars/1/edit
#   def edit
#     @apar = Apar.find(params[:id])
#   end

  # POST /apars
  # POST /apars.xml
#   def create
#     @apar = Apar.new(params[:apar])

#     respond_to do |format|
#       if @apar.save
#         flash[:notice] = 'Apar was successfully created.'
#         format.html { redirect_to(@apar) }
#         format.xml  { render :xml => @apar, :status => :created, :location => @apar }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @apar.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # PUT /apars/1
  # PUT /apars/1.xml
#   def update
#     @apar = Apar.find(params[:id])

#     respond_to do |format|
#       if @apar.update_attributes(params[:apar])
#         flash[:notice] = 'Apar was successfully updated.'
#         format.html { redirect_to(@apar) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @apar.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

  # DELETE /apars/1
  # DELETE /apars/1.xml
#   def destroy
#     @apar = Apar.find(params[:id])
#     @apar.destroy

#     respond_to do |format|
#       format.html { redirect_to(apars_url) }
#       format.xml  { head :ok }
#     end
#   end
end
