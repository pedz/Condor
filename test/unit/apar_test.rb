# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
require 'test_helper'

class AparTest < ActiveSupport::TestCase
  def test_fixtures_loaded
    [ :one, :two, :three ].each do |which|
      temp = Apar.find(apars(which).id)
      assert(temp, "APAR #{which} not found")
      assert_equal(temp.name, apars(which).name)
    end
  end

  def test_first_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Apar.find(apars(which).id)
      assert_not_equal(temp.apar_defect_version_maps.length, 0, "APAR #{which} has no maps")
    end
  end

  def test_second_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Apar.find(apars(which).id)
      assert_equal(temp.defects[0].name, defects(which).name)
      assert_not_equal(temp.versions.length, 0, "APAR #{which} has no versions")
      assert_not_equal(temp.apar_defect_version_maps.length, 0, "APAR #{which} has no maps")
    end
  end

  def test_third_level_associations
    [ :one, :two, :three ].each do |which|
      temp = Apar.find(apars(which).id)
      assert_equal(temp.ptfs[0].name, ptfs(which).name)
      assert_not_equal(temp.releases.length, 0, "Defect #{which} has no releases")
    end
  end

  def test_valid_apar_can_be_saved
    assert(Apar.new(:name => "banana").save)
  end

  def test_name_cannot_be_null
    apar = Apar.new
    assert_equal(apar.save, false)
  end

  def test_name_cannot_be_duplicate
    apar = Apar.new(:name => apars(:one).name)
    v = apar.save
    assert_equal(v, false)
    assert_equal("has already been taken", apar.errors.on(:name))
  end
end
