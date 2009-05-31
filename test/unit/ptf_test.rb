require 'test_helper'

class PtfTest < ActiveSupport::TestCase
  def test_fixtures_loaded
    [ :one, :two, :three ].each do |which|
      temp = Ptf.find(ptfs(which).id)
      assert(temp, "PTF #{which} not found")
      assert_equal(temp.name, ptfs(which).name)
    end
  end

  def test_first_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Ptf.find(ptfs(which).id)
      assert_not_equal(temp.adv_ptf_release_maps.length, 0, "PTF #{which} has no adv_ptf_release_maps")
      assert_not_equal(temp.fileset_ptf_maps.length, 0, "PTF #{which} has no fileset_ptf_maps")
    end
  end

  def test_second_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Ptf.find(ptfs(which).id)
      assert_not_equal(temp.apar_defect_version_maps.length, 0,
                       "PTF #{which} has no apar_defect_version_maps")
      assert_not_equal(temp.ptfs.length, 0, "PTF #{which} has no ptfs")
      assert_not_equal(temp.releases.length, 0, "PTF #{which} has no releases")
      assert_not_equal(temp.filesets.length, 0, "PTF #{which} has no filesets")
      assert_equal(temp.ptfs[0].name, ptfs(which).name)
      assert_equal(temp.releases[0].name, releases(which).name)
    end
  end

  def test_third_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Ptf.find(ptfs(which).id)
      assert_equal(temp.apars[0].name, apars(which).name)
      assert_equal(temp.defects[0].name, defects(which).name)
      assert_not_equal(temp.versions.length, 0, "PTF #{which} has no versions")
    end
  end

  def test valid_ptf_can_be_saved
    assert(Ptf.new(:name => "banana").save)
  end

  def test_name_cannot_be_null
    ptf = Ptf.new
    assert_equal(ptf.save, false)
  end

  def test_name_cannot_be_duplicate
    ptf = Ptf.new(:name => ptfs(:one).name)
    v = ptf.save
    assert_equal(v, false)
    assert_equal("has already been taken", ptf.errors.on(:name))
  end
end
