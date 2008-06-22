require File.dirname(__FILE__) + '/../test_helper'

class FilesetTest < ActiveSupport::TestCase
  fixtures :bases, :lpps, :filesets

  def test_db_setup
    assert (fileset = Fileset.find(:first)), "Didn't find a fileset"
    assert (lpp = fileset.lpp), "Didn't find lpp"
    assert (base = lpp.base), "Didn't find base"
  end
end
