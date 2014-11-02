require 'minitest_helper'

class TestGeneral < TestInterpreterBase
  def setup
  end

  def test_general
    assert_iq_equal('2x', '2x')
    assert_iq_equal('x + x', '2x')
    assert_iq_equal('x * y', 'xy')
  end
end
