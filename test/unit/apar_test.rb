require 'test_helper'

class AparTest < ActiveSupport::TestCase
  def test_fixtures_loaded
    [ :one, :two, :three ].each do |which|
      temp = Apar.find(apars(which).id)
      assert(temp, "APAR #{which} not found")
      assert_equal(temp.name, apars(which).name)
    end
  end

  def test_has_many_apar_defect_version_maps
    [ :one, :two, :three ].each do |which|
      temp = Apar.find(apars(which).id)
      assert_not_equal(temp.apar_defect_version_maps, 0, "APAR #{which} has no maps")
      assert_equal(temp.defects[0].name, defects(which).name, "APAR #{which} not with right defect")
      assert_not_equal(temp.versions, 0, "APAR #{which} has no versions")
    end
  end

  def test_third_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Apar.find(apars(which).id)
      assert_not_equal(temp.ptfs, 0, "APAR #{which} has no ptfs")
      assert_equal(temp.ptfs[0].name, ptfs(which).name, "APAR #{which} not with right PTF")
      assert_not_equal(temp.releases, 0, "APAR #{which} has no releases")
      assert_equal(temp.releases[0].name, releases(which).name, "APAR #{which} not with right release")
    end
  end
end
