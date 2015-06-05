require 'minitest_helper'

class TestTokens < MiniTest::Unit::TestCase
  include Hilbert::Lexer::Tokens
  def setup
  end

  def full_match(rgx, str)
    assert_equal(0, rgx =~ str)
    assert_equal(str, $&)
  end

  def not_match(rgx, str)
    assert_equal(nil, rgx =~ str)
  end

  def test_nums
    full_match(NUM, '1')
    full_match(NUM, '234987423')
    full_match(NUM, '23423948.298743')
    full_match(NUM, 'e')
    full_match(NUM, 'pi')
    not_match(NUM, 'a')
  end

  def test_function
    full_match(/[fgh]\(\w( ?, ?\w)*\) ?= ?[^\r\n]+/, 'f(x) = xy')
  end

  def test_differentiate
    rgx = /d\/d[a-zA-Z] .*/
    full_match(rgx, 'd/dx sin(x)')
    full_match(rgx, 'd/dz z^2')
  end
end
