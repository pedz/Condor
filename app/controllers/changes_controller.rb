class ChangesController < ApplicationController
  def show
    @changes = Change.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar }
    end
  end
end
