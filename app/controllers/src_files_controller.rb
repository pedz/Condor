class SrcFilesController < ApplicationController
  def show
    @params = {
      :release => params[:release],
      :version => params[:version],
      :path => params[:path].join('/')
    }
    @src_file = SrcFile.find(@params, application_user)
    @basename = params[:path].last

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar }
    end
  end
end
