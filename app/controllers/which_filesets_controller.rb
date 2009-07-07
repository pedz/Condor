class WhichFilesetsController < ApplicationController
  def index
    render :text => "hi"
  end

  def show
    @path = params[:path].join('/')
    logger.debug("Accepts = #{request.accepts.inspect}")
    @files = do_find(@path)
    if @files.empty?
      if (md = /(.*)(_?64$|_?32$)/.match(@path))
        @path = md[1]
        @files = do_find(@path)
      elsif (md = /^(.*)(32|64)(\..*)$/.match(@path))
        @path = md[1] + md[3]
        @files = do_find(@path)
      end
    end

    respond_to do |format|
      format.html { render :action => "show" }
      format.xml  {
        render :xml => @files.to_xml(:include => { :filesets => { :include => [:lpp, :service_packs] }})
      }
    end
  end
  
  private
  
  def do_find(path)
    AixFile.find(:all,
                 :conditions => ("basename(path) = basename('#{path}') AND " +
                                 "path LIKE '%#{path}'"),
                 :order => "path",
                 :include => [ { :filesets => :lpp }])
  end
end
