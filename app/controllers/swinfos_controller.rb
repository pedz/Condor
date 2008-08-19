class SwinfosController < ApplicationController
  def index
    show
  end

  def show
    logger.debug("Accepts = #{request.accepts.inspect}")
    item = params[:item]
    item_upcase = item.upcase
    logger.debug("ITEM is '#{item}'")
    case item_upcase
      # APAR
    when /^I[XYZ][0-9][0-9][0-9][0-9][0-9]$/
      @items = Ptfapardef.find_all_by_apar(item_upcase)

      # Defect
    when /^[0-9]+$/
      @items = Ptfapardef.find_all_by_defect(item)

      # PTF
    when /^U[0-9][0-9][0-9][0-9][0-9][0-9]$/
      @items = Ptfapardef.find_all_by_ptf(item_upcase)

      # Fileset name with vrmf
    when /^([^ ]+) +([^ ]+)$/
      lpp, vrmf = item.split(' ')
      @items = Ptfapardef.find_all_by_lpp(lpp,
                                          :conditions => [ 'vrmf LIKE ?', "#{vrmf}%"])

      # Just a fileset name
    else
      @items = Ptfapardef.find_all_by_lpp(item)

    end

    respond_to do |format|
      format.html { render :action => "show" }
      format.xml  { render :xml => @items.to_xml }
    end
  end
end
