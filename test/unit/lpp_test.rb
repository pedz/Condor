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
end
