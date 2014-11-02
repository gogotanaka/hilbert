require 'minitest_helper'

class TestQlang < MiniTest::Unit::TestCase
  def setup
  end

  def assert_to_ruby(input, output)
    assert_equal(Q.to_ruby.compile(input), output)
  end

  def test_basis
    refute_nil ::Qlang::VERSION
    assert_equal(Qlang, Q)
  end

  def test_demo_code
    assert_to_ruby('d/dx(sin(x))', 'd/dx(sin(x))')
    assert_to_ruby('d/dx(log(x))', 'd/dx(log(x))')
    assert_to_ruby('f(x, y) = x + y', 'f(x, y) <= x + y')
    assert_equal(Matrix[[1, 2, 3], [4, 5, 6]].to_q, '(1 2 3; 4 5 6)')
    assert_equal(Vector[1, 2, 3].to_q, '(1 2 3)')
  end
end

