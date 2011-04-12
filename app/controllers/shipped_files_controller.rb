class ShippedFilesController < ApplicationController
  def show
    @shipped_files = ShippedFile.find(:all, :conditions => { :aix_file_sha1 => params[:sha1]})
  end
end
