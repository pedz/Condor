class SwinfosController < ApplicationController
  def show
    logger.debug("Accepts = #{request.accepts.inspect}")
    @param = params[:item]
    respond_to do |format|
      format.html { render :action => "show", :layout => "spry" }
      format.json {
        item = @param
        item_upcase = item.upcase
        case item_upcase
        when /^I[XYZ][0-9][0-9][0-9][0-9][0-9]$/ # APAR
          @items = Ptfapardef.find_all_by_apar(item_upcase)
          
        when /^[0-9]+$/         # Defect
          @items = Ptfapardef.find_all_by_defect(item)
          

        when /^U[0-9][0-9][0-9][0-9][0-9][0-9]$/ # PTF
          @items = Ptfapardef.find_all_by_ptf(item_upcase)
          
        when /^([^ ]+) +([^ ]+)$/ # Fileset name with vrmf
          lpp, vrmf = item.split(' ')
          @items = Ptfapardef.find_all_by_lpp(lpp,
                                              :conditions => [ 'vrmf LIKE ?', "#{vrmf}%"])

        else                    # Just a fileset name
          @items = Ptfapardef.find_all_by_lpp(item)
        end
        @items.each { |item| item.controller = self }
        render :json => @items.to_json(:only => [:defect, :apar, :ptf, :abstract,
                                                 :lpp, :vrmf, :release,
                                                 :version ],
                                       :methods => [ :apar_draft_defect_path,
                                                     :apar_draft_apar_path,
                                                     :swinfos_defect_path,
                                                     :defect_path,
                                                     :changes_path,
                                                     :swinfos_apar_path,
                                                     :swinfos_ptf_path,
                                                     :swinfos_lpp_path,
                                                     :swinfos_fileset_path,
                                                     :fileset_path])
      }
    end
  end
end


#       format.html { render :action => "show" }
#       format.xml  { render :xml => @items.to_xml }
#       format.json {
#         logger.debug("json: #{@items.inspect}")
#       }
