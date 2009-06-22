class Ptfapardef < ActiveRecord::Base
  def controller=(controller)
    @controller = controller
  end

  def defect_path
    @controller.__send__(:defect_path, defect)
  end

  def changes_path
    @controller.__send__(:changes_path, defect)
  end

  def swinfos_defect_path
    swinfors_path(defect)
  end

  def swinfos_apar_path
    swinfors_path(apar)
  end

  def swinfos_ptf_path
    swinfors_path(ptf)
  end

  def swinfos_lpp_path
    swinfors_path(lpp)
  end

  def fileset_path
    if !fileset_id.nil?
      @controller.__send__(:fileset_path, fileset_id)
    else
      ""
    end
  end

  def swinfos_fileset_path
    swinfors_path("#{lpp} #{vrmf}")
  end

  private

  def swinfors_path(id)
    if !id.nil?
      @controller.__send__(:swinfos_path, id)
    else
      ""
    end
  end
end
