module Dydx
  module Algebra
    class Inverse
      include Helper
      attr_accessor :x, :operator

      def initialize(x, operator)
        @x, @operator = x, operator
      end

      def to_s
        case operator
        when :+ then "( - #{x} )"
        when :* then "( 1 / #{x} )"
        end
      end

      def differentiate(sym=:x)
        case operator
        when :+
          inverse(x.differentiate(sym), :+)
        when :*
          inverse(x.differentiate(sym) * inverse(x ^ 2, :*), :+)
        end
      end
      alias_method :d, :differentiate
    end
  end
end
