require './spec/minitests/interpreter/base'

class TestMatrix < TestInterpreterBase
  def setup

  end

  def test_integer
    assert_iq_equal(
      '(1 2 3; 4 5 6)',
      '(1 2 3; 4 5 6)'
    )

    assert_iq_equal(
      '(1 2 3; 4 5 6) + (1 2 3; 4 5 6)',
      '(2 4 6; 8 10 12)'
    )

    assert_iq_equal(
      '(1 2 3; 4 5 6) - (2 4 1; 8 3 9)',
      '(-1 -2 2; -4 2 -3)'
    )

    assert_iq_equal(
      '(1 2; 3 4) * (1 2; 3 4)',
      '(7 10; 15 22)'
    )

    assert_iq_equal(
      '(1 2; 3 4) ** 2',
      '(7 10; 15 22)'
    )

    assert_iq_equal(
      '(1 2; 3 4) ** 2',
      '(7 10; 15 22)'
    )

    assert_iq_equal(
      '(1 2; 3 4) * (1 2)',
      '(5 11)'
    )

    assert_iq_equal(
      '(1 2 3; 4 5 6)t',
      '(1 4; 2 5; 3 6)'
    )

    assert_iq_equal(
      '(1 2 3
        4 5 6) +
       (1 2 3
        4 5 6)',
      '(2 4 6; 8 10 12)'
    )
  end

  def test_float
    assert_iq_equal(
      '(1.0  2.0  3
        4.2  5.3  6)t',
      '(1.0 4.2; 2.0 5.3; 3 6)'
    )

    assert_iq_equal(
      '(1.0  2.0  3
        4.2  5.3  6)t',
      '(1.0 4.2; 2.0 5.3; 3 6)'
    )
  end
end
