require 'test_helper'

class DefectTest < ActiveSupport::TestCase
  def test_fixtures_loaded
    [ :one, :two, :three ].each do |which|
      temp = Defect.find(defects(which).id)
      assert(temp, "defect #{which} not found")
      assert_equal(temp.name, defects(which).name)
    end
  end

  def test_has_many_defect_defect_version_maps
    [ :one, :two, :three ].each do |which|
      temp = Defect.find(defects(which).id)
      assert_not_equal(temp.apar_defect_version_maps, 0, "defect #{which} has no maps")
      assert_equal(temp.apars[0].name, apars(which).name, "defect #{which} not with right APAR")
      assert_not_equal(temp.versions, 0, "defect #{which} has no versions")
    end
  end

  def test_has_many_defect_defect_version_maps
    [ :one, :two, :three ].each do |which|
      temp = Defect.find(defects(which).id)
      assert_not_equal(temp.ptfs, 0, "defect #{which} has no ptfs")
      assert_equal(temp.ptfs[0].name, ptfs(which).name, "defect #{which} not with right PTF")
      assert_not_equal(temp.releases, 0, "defect #{which} has no releases")
      assert_equal(temp.releases[0].name, releases(which).name, "defect #{which} not with right release")
    end
  end
end
