require 'minitest_helper'

class TestVector < TestInterpreterBase
  def setup

  end

  def test_integer
    assert_iq_equal(
      '(1 2 3)',
      '(1 2 3)'
    )

    assert_iq_equal(
      '(1 2 3) + (1 2 3)',
      '(2 4 6)'
    )

    assert_iq_equal(
      '(1  2  3 )  +  ( 1 2 3 )',
      '(2 4 6)'
    )

    assert_iq_equal(
      '(1 2 3) - (1 2 3) - (1 2 3)',
      '(-1 -2 -3)'
    )
  end
end
