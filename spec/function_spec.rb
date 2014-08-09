require 'spec_helper'

describe QLang do
  describe 'Function' do
    it do
      expect(
        Q.compile('f(x, y) = x + y')
      ).to eq(
        "f <- function(x ,y) x + y"
      )

      expect(
        Q.compile('g(x) = x ** 2')
      ).to eq(
        "g <- function(x) x ** 2"
      )

      expect(
        Q.compile('g(x) = x ** (2 + 2)')
      ).to eq(
        "g <- function(x) x ** (2 + 2)"
      )

      expect(
        Q.compile('h(a, b, c) = a ** 2 + b ** 2 + c ** 2')
      ).to eq(
        "h <- function(a ,b ,c) a ** 2 + b ** 2 + c ** 2"
      )
    end
  end
end
