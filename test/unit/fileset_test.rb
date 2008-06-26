require File.dirname(__FILE__) + '/../test_helper'

class FilesetTest < ActiveSupport::TestCase
  fixtures :lpp_bases, :lpps, :filesets

  def test_db_setup
    assert (fileset = Fileset.find(:first)), "Didn't find a fileset"
    assert (lpp = fileset.lpp), "Didn't find lpp"
    assert (lpp_base = lpp.lpp_base), "Didn't find lpp_base"
  end
end
