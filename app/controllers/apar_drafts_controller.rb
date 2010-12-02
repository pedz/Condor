class AparDraftsController < ApplicationController
  APAR_DRAFT_URL = "https://amt.austin.ibm.com/cgi-bin/secure_aparmgt?search_type=%s&search_arg=%s&ACTION=draft_search"
  def show
    new_url = APAR_DRAFT_URL % [params[:search_type], params[:search_arg]]
    redirect_to new_url
  end
end
