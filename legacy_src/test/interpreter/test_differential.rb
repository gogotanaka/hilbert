require 'minitest_helper'

class TestDifferential < TestInterpreterBase

  # TODO: opposite
  def [output, input)
    assert_equal(output, Hilbert::Iq.execute(input))
  end

  def setup
  end

  def test_general
    [
      'e ^ x',
      'd/dx(e ** x)'
    ]

    [
      '2x',
      'd/dx(x ** 2)'
    ]

    [
      '2',
      'd/dx(x * 2)'
    ]

    [
      'cos( x )',
      'd/dx( sin(x) )'
    ]

    [
      '1 / x',
      'd/dx(log(x))'
    ]

    [
      '- sin( x )',
      'd/dx cos(x)'
    ]

    [
      '2x',
      'd/dx xx'
    ]

    [
      '1 / x',
      'd/dx log(x)'
    ]

    [
      '( cos( x ) / x ) + ( log( x )( - sin( x ) ) )',
      'd/dx log(x) * cos(x)'
    ]
  end
end
