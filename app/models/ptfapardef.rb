class Ptfapardef < ActiveRecord::Base
  def controller=(controller)
    @controller = controller
  end

  def apar_draft_defect_path
    if attributes.has_key? "defect"
      @controller.__send__(:apar_drafts_path, "defect", defect)
    else
      ""
    end
  end

  def apar_draft_apar_path
    logger.debug(self.attributes.inspect)
    if attributes.has_key? "apar"
      @controller.__send__(:apar_drafts_path, "apar", apar)
    else
      ""
    end
  end

  def defect_path
    if attributes.has_key? "defect"
      @controller.__send__(:defect_path, defect)
    else
      ""
    end
  end

  def changes_path
    if attributes.has_key? "defect"
      @controller.__send__(:changes_path, defect)
    else
      ""
    end
  end

  def swinfos_defect_path
    if attributes.has_key? "defect"
      swinfors_path(defect)
    else
      ""
    end
  end

  def swinfos_apar_path
    if attributes.has_key? "apar"
      swinfors_path(apar)
    else
      ""
    end
  end

  def swinfos_ptf_path
    if attributes.has_key? "ptf"
      swinfors_path(ptf)
    else
      ""
    end
  end

  def swinfos_lpp_path
    if attributes.has_key? "lpp"
      swinfors_path(lpp)
    else
      ""
    end
  end

  def fileset_path
    if attributes.has_key? "fileset_id"
      @controller.__send__(:filesets_path, fileset_id)
    else
      ""
    end
  end

  def swinfos_fileset_path
    if attributes.has_key?("vrmf") && attributes.has_key?("lpp")
      swinfors_path("#{lpp} #{vrmf}")
    else
      ""
    end
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
