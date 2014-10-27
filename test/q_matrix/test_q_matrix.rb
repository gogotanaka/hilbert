require 'minitest_helper'
require 'qlang/qlang'

class TestQMatrix < TestInterpreterBase
  def setup
  end

  def test_main
    #assert_equal(50.0, QMatrix.new.func(10))

    assert_equal(8.0, QMatrix.new.execute(0, 2, 100))
  end
end
