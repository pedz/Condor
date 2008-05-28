class LppsController < ApplicationController
  # GET /lpps
  # GET /lpps.xml
  def index
    @lpps = Lpps.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lpps }
    end
  end

  # GET /lpps/1
  # GET /lpps/1.xml
  def show
    @lpps = Lpps.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lpps }
    end
  end

  # GET /lpps/new
  # GET /lpps/new.xml
  def new
    @lpps = Lpps.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lpps }
    end
  end

  # GET /lpps/1/edit
  def edit
    @lpps = Lpps.find(params[:id])
  end

  # POST /lpps
  # POST /lpps.xml
  def create
    @lpps = Lpps.new(params[:lpps])

    respond_to do |format|
      if @lpps.save
        flash[:notice] = 'Lpps was successfully created.'
        format.html { redirect_to(@lpps) }
        format.xml  { render :xml => @lpps, :status => :created, :location => @lpps }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lpps.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lpps/1
  # PUT /lpps/1.xml
  def update
    @lpps = Lpps.find(params[:id])

    respond_to do |format|
      if @lpps.update_attributes(params[:lpps])
        flash[:notice] = 'Lpps was successfully updated.'
        format.html { redirect_to(@lpps) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lpps.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lpps/1
  # DELETE /lpps/1.xml
  def destroy
    @lpps = Lpps.find(params[:id])
    @lpps.destroy

    respond_to do |format|
      format.html { redirect_to(lpps_url) }
      format.xml  { head :ok }
    end
  end
end
