require 'minitest_helper'

class TestDifferential < TestInterpreterBase
  def setup

  end

  def test_general
    assert_iq_equal(
      'd/dx(e ** x)',
      'e ^ x'
    )

    assert_iq_equal(
      'd/dx(x ** 2)',
      '2x'
    )

    assert_iq_equal(
      'd/dx(x * 2)',
      '2'
    )

    assert_iq_equal(
      'd/dx( sin(x) )',
      'cos( x )'
    )

    assert_iq_equal(
      'd/dx(log( x ))',
      '1 / x'
    )

    assert_iq_equal(
      'd/dx cos(x)',
      '- sin( x )'
    )

    assert_iq_equal(
      'd/dx xx',
      '2x'
    )
  end
end
