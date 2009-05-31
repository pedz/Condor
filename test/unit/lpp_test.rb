require 'test_helper'

class LppTest < ActiveSupport::TestCase
  def test_fixtures_loaded
    tty = Lpp.find(lpps(:tty).id)
    assert(tty, "tty not found")
    assert_equal(tty.name, lpps(:tty).name)
    adapter = Lpp.find(lpps(:adapter).id)
    assert(adapter, "adapter not found")
    assert_equal(adapter.name, lpps(:adapter).name)
  end

  def test_belongs_to
    tty = Lpp.find(lpps(:tty).id)
    assert(bos = tty.lpp_base, "bos lpp_base not found")
    assert_equal(bos.name, lpp_bases(:bos).name)
    adapter = Lpp.find(lpps(:adapter).id)
    assert(devices = adapter.lpp_base, "devices lpp_base not found")
    assert_equal(devices.name, lpp_bases(:devices).name)
  end

  def test_name_cannot_be_null
    t = Lpp.find(lpps(:tty).id)
    t.name = nil
    assert_equal(false, t.save, "Save with name set to null should have failed")
    assert_equal("can't be blank", t.errors.on(:name))
  end

  def test_lpp_base_id_cannot_be_null
    t = Lpp.find(lpps(:tty).id)
    t.lpp_base_id = nil
    assert_equal(false, t.save, "Save with lpp_base_id set to null should have failed")
    assert_equal("can't be blank", t.errors.on(:lpp_base_id))
  end

  def test_name_and_base_cannot_be_duplicate
    t = Lpp.find(lpps(:tty).id)
    n = Lpp.new(:name => t.name, :lpp_base_id => t.lpp_base_id)
    assert_equal(false, n.save, "Save with duplicate name and lpp base id should have failed.")
    assert_equal("has already been taken", n.errors.on(:name), "name did not get right error")
    assert_equal("has already been taken", n.errors.on(:lpp_base_id), "lpp_base_id did not get right error")
  end

  def test_lpp_base_id_is_foreign_key
    t = Lpp.find(lpps(:tty).id)
    t.lpp_base_id = 18
    assert_equal(false, t.save, "Save with bad lpp_baes_id should have failed")
    assert_equal("is invalid", t.errors.on(:lpp_base_id), "lpp_base_id did not have right error")
  end
end
