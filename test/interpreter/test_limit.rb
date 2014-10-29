require 'minitest_helper'

class TestLimit < TestInterpreterBase
  def setup

  end

  def test_general
    assert_iq_equal(
      'lim[x->0](1/x)',
      'oo'
    )

    assert_iq_equal(
      'lim[x->10] x',
      '10.0'
    )
  end
end
