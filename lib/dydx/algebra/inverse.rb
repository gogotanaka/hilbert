module Dydx
  module Algebra
    class Inverse
      include Helper
      attr_accessor :x, :operator

      def initialize(x, operator)
        @x, @operator = x, operator
      end

      def to_s
        # sym = {'*'=>'/', '+'=>'-'}[operator.to_s]
        case operator
        when :+
          "( - #{x} )"
        when :*
          "( 1 / #{x} )"
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

      def ==(x)
        to_s == x.to_s
      end
    end
  end
end