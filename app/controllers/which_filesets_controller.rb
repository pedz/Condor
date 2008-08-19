class WhichFilesetsController < ApplicationController
  def index
    render :text => "hi"
  end

  def show
    path = params[:path].join('/')
    logger.debug("Accepts = #{request.accepts.inspect}")
    @files = AixFile.find(:all,
                          :conditions => ("basename(path) = basename('#{path}') AND " +
                                          "path LIKE '%#{path}'"),
                          :order => "path",
                          :include => [ { :filesets => :lpp }])

    respond_to do |format|
      format.html { render :action => "show" }
      format.xml  { render :xml => @files.to_xml(:include => { :filesets => { :include => :lpp }}) }
    end
  end
end
