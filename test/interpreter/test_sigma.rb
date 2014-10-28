require 'minitest_helper'

class TestSigma < TestInterpreterBase
  def setup

  end

  def test_general
    assert_iq_equal(
      '∑[x=0,10](x)',
      '55.0'
    )
  end
end
