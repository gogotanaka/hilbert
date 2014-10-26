require 'minitest_helper'

class TestIntegral < TestInterpreterBase
  def setup

  end

  def test_general
    assert_iq_equal(
      'S( log(x)dx )[0..1]',
      '-oo'
    )

    assert_iq_equal(
      'S( sin(x)dx )[0..pi]',
      '2.0'
    )

    assert_iq_equal(
      'S( cos(x)dx )[0..pi]',
      '0.0'
    )

    assert_iq_equal(
      'S( cos(x)dx )[0..pi]',
      '0.0'
    )

    assert_iq_equal(
      'S(2pi dx)[0..1]',
      '6.28318531'
    )

    assert_iq_equal(
      'S(xx dx)[0..1]',
      '0.33333333'
    )
  end
end
