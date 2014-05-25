module Dydx
  class Integrand
    attr_accessor :function, :var
    def initialize(function, var)
      @function = function
      @var = var
    end

    def [](a, b, n = 100)
      f = function
      a, b = [a, b].map(&:to_f)
      raise ArgumentError, 'b should be greater than a' if a > b
      h = (b - a) / n
      sum = 0.0
      xi = ->(i){ a + h * i }
      n.to_i.times do |i|
        sum += ( f(xi.(i)) + 4.0 * f(xi.(i) + h / 2.0 ) + f(xi.(i) + h) )
      end
      ( h * sum ) / 6.0
    end
  end
end
