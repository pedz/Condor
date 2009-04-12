require 'test_helper'

class LppBaseTest < ActiveSupport::TestCase
  def test_fixtures_loaded
    assert(LppBase.find(lpp_bases(:bos).id),     "bos lpp_base not found")
    assert(LppBase.find(lpp_bases(:devices).id), "devices lpp_base not found")
  end
end
