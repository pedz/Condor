require 'test_helper'

class LppBaseTest < ActiveSupport::TestCase
  def test_fixtures_loaded
    assert(LppBase.find(lpp_bases(:bos).id),     "bos lpp_base not found")
    assert(LppBase.find(lpp_bases(:devices).id), "devices lpp_base not found")
  end

  def test_first_level_associations
    [ :bos, :devices].each do |which|
      temp = LppBase.find(lpp_bases(which))
      assert_not_equal(temp.lpps.length, 0, "#{which} has no lpps")
    end
  end

  def test valid_lpp_base_can_be_saved
    assert(LppBase.new(:name => "banana").save)
  end

  def test_name_cannot_be_null
    lpp_base = LppBase.new
    assert_equal(lpp_base.save, false)
    assert_equal("can't be blank", lpp_base.errors.on(:name))
  end

  def test_name_cannot_be_duplicate
    lpp_base = LppBase.new(:name => lpp_bases(:bos).name)
    v = lpp_base.save
    assert_equal(v, false)
    assert_equal("has already been taken", lpp_base.errors.on(:name))
  end
end
