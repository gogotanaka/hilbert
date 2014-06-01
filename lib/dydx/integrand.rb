module Dydx
  class Integrand
    attr_accessor :function, :var
    def initialize(function, var)
      @function = function
      @var = var
    end

    def [](a, b, n = 1000)
      # HOT FIX: should implement Infinity class
      a = - 1000 if a == - Float::INFINITY
      b = 1000 if b == Float::INFINITY

      a, b = [a, b].map(&:to_f)
      raise ArgumentError, 'b should be greater than a' if a > b
      f = function

      n = [n, (b - a) * 2].max
      n += 1 if n.to_i.odd?
      h = (b - a) / n
      x = ->(i){ a + h * i }

      odd_sum = (1..n - 1).to_a.select(&:odd?).inject(0) { |sum, i| sum += f(x.(i))}
      even_sum = (1..n - 1).to_a.select(&:even?).inject(0) { |sum, i| sum += f(x.(i))}
      round_8( (h / 3) * (f(a) + f(b) + 2 * even_sum + 4 * odd_sum) )
    end

    def round_8(num)
      return num if num.abs == Float::INFINITY
      (num * 10 ** 8).round * 10.0 ** (-8)
    end
  end
end
