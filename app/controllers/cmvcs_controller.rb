class CmvcsController < ApplicationController
  # GET /cmvcs
  # GET /cmvcs.xml
  def index
    @cmvcs = Cmvc.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cmvcs }
    end
  end

  # GET /cmvcs/1
  # GET /cmvcs/1.xml
  def show
    @cmvc = Cmvc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cmvc }
    end
  end

  # GET /cmvcs/new
  # GET /cmvcs/new.xml
  def new
    @cmvc = Cmvc.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cmvc }
    end
  end

  # GET /cmvcs/1/edit
  def edit
    @cmvc = Cmvc.find(params[:id])
  end

  # POST /cmvcs
  # POST /cmvcs.xml
  def create
    @cmvc = Cmvc.new(params[:cmvc])

    respond_to do |format|
      if @cmvc.save
        flash[:notice] = 'Cmvc was successfully created.'
        format.html { redirect_to(@cmvc) }
        format.xml  { render :xml => @cmvc, :status => :created, :location => @cmvc }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cmvc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cmvcs/1
  # PUT /cmvcs/1.xml
  def update
    @cmvc = Cmvc.find(params[:id])

    respond_to do |format|
      if @cmvc.update_attributes(params[:cmvc])
        flash[:notice] = 'Cmvc was successfully updated.'
        format.html { redirect_to(@cmvc) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cmvc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cmvcs/1
  # DELETE /cmvcs/1.xml
  def destroy
    @cmvc = Cmvc.find(params[:id])
    @cmvc.destroy

    respond_to do |format|
      format.html { redirect_to(cmvcs_url) }
      format.xml  { head :ok }
    end
  end
end
