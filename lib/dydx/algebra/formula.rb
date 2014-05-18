module Dydx
  module Algebra
    class Formula
      include Helper
      attr_accessor :f, :g, :operator

      def initialize(f, g, operator)
        @f, @g, @operator = f, g, operator
      end

      def differentiate(sym=:x)
        case @operator
        when :+
          f.d(sym) + g.d(sym)
        when :*
          (f.d(sym) * g) + (f * g.d(sym))
        when :^
          # TODO:
          if f == sym
            g * (f ^ (g - 1))
          elsif f == e
            g.d(sym) * self
          else
            self * (g * log(f)).d(sym)
          end
        end
      end
      alias_method :d, :differentiate

      def to_s
        if (multiplication? && (f.is_minus1? || g.is_minus1?)  )
          "( - #{g.to_s} )"
        elsif multiplication? && g.divisor?
          "( #{f.to_s} / #{g.x.to_s} )"
        elsif multiplication? && f.divisor?
          "( #{g.to_s} / #{f.x.to_s} )"
        elsif addition? && g.subtrahend?
          "( #{f.to_s} - #{g.x.to_s} )"
        elsif addition? && f.subtrahend?
          "( #{g.to_s} - #{f.x.to_s} )"
        else
          "( #{f.to_s} #{@operator} #{g.to_s} )"
        end
      end

      def include?(x)
        f == x || g == x
      end

      def openable?(x)
        x.is_num? && (f.is_num? || g.is_num?)
      end

      def ==(x)
        to_s == x.to_s
      end
    end
  end
end