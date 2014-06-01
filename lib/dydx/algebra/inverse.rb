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

      def subst(hash = {})
        case operator
        when :+ then x.subst(hash) * -1
        when :* then x.subst(hash) ** -1
        end
      end

      def to_f
        case operator
        when :+ then x.to_f * -1
        when :* then x.to_f ** -1
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
