class BasesController < ApplicationController
  # GET /bases
  # GET /bases.xml
  def index
    @bases = Base.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bases }
    end
  end

  # GET /bases/1
  # GET /bases/1.xml
  def show
    @base = Base.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @base }
    end
  end

  # GET /bases/new
  # GET /bases/new.xml
  def new
    @base = Base.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @base }
    end
  end

  # GET /bases/1/edit
  def edit
    @base = Base.find(params[:id])
  end

  # POST /bases
  # POST /bases.xml
  def create
    @base = Base.new(params[:base])

    respond_to do |format|
      if @base.save
        flash[:notice] = 'Base was successfully created.'
        format.html { redirect_to(@base) }
        format.xml  { render :xml => @base, :status => :created, :location => @base }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @base.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bases/1
  # PUT /bases/1.xml
  def update
    @base = Base.find(params[:id])

    respond_to do |format|
      if @base.update_attributes(params[:base])
        flash[:notice] = 'Base was successfully updated.'
        format.html { redirect_to(@base) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @base.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bases/1
  # DELETE /bases/1.xml
  def destroy
    @base = Base.find(params[:id])
    @base.destroy

    respond_to do |format|
      format.html { redirect_to(bases_url) }
      format.xml  { head :ok }
    end
  end
end
