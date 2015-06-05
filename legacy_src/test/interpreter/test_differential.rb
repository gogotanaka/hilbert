require 'minitest_helper'

class TestDifferential < TestInterpreterBase

  # TODO: opposite
  def assert_iq_equal(output, input)
    assert_equal(output, Hilbert::Iq.execute(input))
  end

  def setup
  end

  def test_general
    assert_iq_equal(
      'e ^ x',
      'd/dx(e ** x)'
    )

    assert_iq_equal(
      '2x',
      'd/dx(x ** 2)'
    )

    assert_iq_equal(
      '2',
      'd/dx(x * 2)'
    )

    assert_iq_equal(
      'cos( x )',
      'd/dx( sin(x) )'
    )

    assert_iq_equal(
      '1 / x',
      'd/dx(log(x))'
    )

    assert_iq_equal(
      '- sin( x )',
      'd/dx cos(x)'
    )

    assert_iq_equal(
      '2x',
      'd/dx xx'
    )

    assert_iq_equal(
      '1 / x',
      'd/dx log(x)'
    )

    assert_iq_equal(
      '( cos( x ) / x ) + ( log( x )( - sin( x ) ) )',
      'd/dx log(x) * cos(x)'
    )
  end
end
