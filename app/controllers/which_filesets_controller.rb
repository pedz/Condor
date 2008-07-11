class WhichFilesetsController < ApplicationController
  def show
    path = params[:path].join('/')
    @files = AixFile.find(:all,
                          :conditions => ("basename(path) = basename('#{path}') AND " +
                                          "path LIKE '%#{path}'"),
                          :order => "path",
                          :include => [ { :filesets => :lpp }])
  end
end
