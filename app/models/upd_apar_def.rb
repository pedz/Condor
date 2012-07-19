# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#

# This model is a view in the database.  See AddUpdAparDefsView
# migration for details.
class UpdAparDef < ActiveRecord::Base
  ##
  # :attr: abstract
  # abstract from Apar

  ##
  # :attr: apar
  # name from Apar

  ##
  # :attr: apar_id
  # id from Apar

  ##
  # :attr: build_name
  # bc_name from UpdPcView
  
  ##
  # :attr: cq_defect
  # cq_defect from Defect

  ##
  # :attr: defect
  # name from Defect

  ##
  # :attr: defect_id
  # id from Defect

  ##
  # :attr: fileset_id
  # id from Fileset

  ##
  # :apar: lpp
  # name from Lpp

  ##
  # :apar: lpp_id
  # id from Lpp

  ##
  # :apar: lpp_base
  # name from LppBase

  ##
  # :apar: lpp_base_id
  # id from LppBase

  ##
  # :apar: ptf
  # name from Ptf

  ##
  # :apar: ptf_id
  # id from Ptf

  ##
  # :apar: service_pack
  # name from ServicePack

  ##
  # :apar: service_pack_id
  # id from ServicePack

  ##
  # :apar: version
  # name from Version

  ##
  # :apar: version_id
  # id from Version

  ##
  # :apar: vrmf
  # vrmf from Fileset

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
