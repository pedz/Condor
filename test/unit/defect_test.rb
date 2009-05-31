require 'test_helper'

class DefectTest < ActiveSupport::TestCase
  def test_fixtures_loaded
    [ :one, :two, :three ].each do |which|
      temp = Defect.find(defects(which).id)
      assert(temp, "defect #{which} not found")
      assert_equal(temp.name, defects(which).name)
    end
  end

  def test_first_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Defect.find(defects(which).id)
      assert_not_equal(temp.apar_defect_version_maps.length, 0, "defect #{which} has no maps")
      assert_equal(temp.apars[0].name, apars(which).name, "defect #{which} not with right APAR")
      assert_not_equal(temp.versions, 0, "defect #{which} has no versions")
    end
  end

  def test_second_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Defect.find(defects(which).id)
      assert_equal(temp.apars[0].name, apars(which).name)
      assert_not_equal(temp.versions.length, 0, "Defect #{which} has no versions")
      assert_not_equal(temp.apar_defect_version_maps.length, 0, "Defect #{which} has no maps")
    end
  end

  def third_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Defect.find(defects(which).id)
      assert_equal(temp.ptfs[0].name, ptfs(which).name)
      assert_not_equal(temp.releases,length, 0, "Defect #{which} has no releases")
    end
  end

  def test valid_defect_can_be_saved
    assert(Defect.new(:name => "banana").save)
  end

  def test_name_cannot_be_null
    defect = Defect.new
    assert_equal(defect.save, false)
  end

  def test_name_cannot_be_duplicate
    defect = Defect.new(:name => defects(:one).name)
    v = defect.save
    assert_equal(v, false)
    assert_equal("has already been taken", defect.errors.on(:name))
  end
end
