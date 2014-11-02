require 'minitest_helper'

class TestSigma < TestInterpreterBase
  def setup
  end

  def test_general
    assert_iq_equal(
      '∑[x=0,10] x',
      '55.0'
    )

    assert_iq_equal(
      '∑[x=0, 10] x^2',
      '385.0'
    )

    assert_iq_equal(
      '∑[x=0, 10] x^3',
      '3025.0'
    )
  end
end
