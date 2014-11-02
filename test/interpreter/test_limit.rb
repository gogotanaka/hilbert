require 'minitest_helper'

class TestLimit < TestInterpreterBase
  def setup
  end

  def assert_iq_equal(output, input)
    assert_equal(Qlang::Iq.execute(input), output)
  end

  def test_general
    assert_iq_equal(
      'oo',
      'lim[x->0] 1/x'
    )

    assert_iq_equal(
      '10.0',
      'lim[x->10] x'
    )

    # assert_iq_equal(
    #   '2.7182682371744895',
    #   'lim[x->oo] (1 + 1/x)^x'
    # )

    assert_iq_equal(
      'oo',
      'lim[x->oo] x'
    )

    assert_iq_equal(
      '0.0',
      'lim[x->0] x'
    )
  end
end
