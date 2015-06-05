require 'minitest_helper'

class TestGeneral < TestInterpreterBase
  def setup
  end

  # TODO: opposite
  def assert_iq_equal(output, input)
    assert_equal(output, Hilbert::Iq.execute(input))
  end

  def test_general
    assert_iq_equal('2', '1 + 1')
    assert_iq_equal('3 / 2', '1 + 1/2')
    assert_iq_equal('1', '1/2 + 1/2')
    assert_iq_equal('2x', '2x')
    assert_iq_equal('2x', 'x + x')
    # assert_iq_equal('xy', 'xy')
    assert_iq_equal('x ^ y', 'x ^ y')
    assert_iq_equal('2sin( x )', 'sin(x) + sin(x)')
    assert_iq_equal('log( x ) ^ 2', 'log(x) * log(x)')
  end
end
