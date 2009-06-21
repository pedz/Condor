class Ptfapardef < ActiveRecord::Base
  def controller=(controller)
    @controller = controller
  end

  def defect_path
    url_for(defect)
  end

  def apar_path
    url_for(apar)
  end

  def ptf_path
    url_for(ptf)
  end

  def lpp_path
    url_for(lpp)
  end

  def fileset_path
    url_for("#{lpp} #{vrmf}")
  end

  private

  def url_for(id)
    if !id.nil?
      @controller.__send__(:swinfos_path, id)
    else
      ""
    end
  end
end
