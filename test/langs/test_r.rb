require 'minitest_helper'

class TestR < TestInterpreterBase
  def setup
  end

  def assert_r_compl_eq(output, input)
    assert_equal(output, Q.to_r.compile(input))
  end

  def test_function
    assert_r_compl_eq(
      "f <- function(x, y) x + y",
      'f(x, y) = x + y'
    )

    assert_r_compl_eq(
      "g <- function(x) x ^ 2",
      'g(x) = x ^ 2'
    )

    assert_r_compl_eq(
      "g <- function(x) x ^ (2 + 2)",
      'g(x) = x ^ (2 + 2)'
    )

    assert_r_compl_eq(
      "h <- function(a, b, c) a ^ 2 + b ^ 2 + c ^ 2",
      'h(a, b, c) = a ^ 2 + b ^ 2 + c ^ 2'
    )
  end
end
