require 'hilbert/iq'

class TestInterpreterBase < MiniTest::Unit::TestCase
  # TODO: opposite
  def assert_iq_equal(input, output)
    assert_equal(Qlang::Iq.execute(input), output)
  end

  def assert_def_func(input, output)
    assert_equal(Qlang::Iq.execute(input), output)
  end

  def assert_cal_func(input, output)
    assert_equal(Qlang::Iq.execute(input), output)
    reset
  end
end
