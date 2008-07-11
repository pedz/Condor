class SwinfosController < ApplicationController
  def show
    item = params[:item].upcase
    case item
      # APAR
    when /^I[XYZ][0-9][0-9][0-9][0-9][0-9]$/
      @items = Ptfapardef.find_all_by_apar(item)
      logger.debug("#{@items[0].attributes.inspect}")

      # PTF
    when /^[0-9]+$/
      # Defect
    when /^U[0-9][0-9][0-9][0-9][0-9][0-9]$/
      # Fileset name with vrmf
    when /^([^ ]+) +([^ ]+)$/
      # Just a fileset name
    else
    end
  end
end
