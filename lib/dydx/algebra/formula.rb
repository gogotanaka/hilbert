module Dydx
  module Algebra
    class Formula
      include Helper
      attr_accessor :f, :operator, :g

      def initialize(f, g, operator)
        g, f = f, g if g.is_num? && operator.commutative?
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
          if g.is_num?
            f.d(sym) * g * (f ^ (g - 1) )
          elsif f == sym
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
        elsif multiplication? && g.inverse?(:*)
          "( #{f.to_s} / #{g.x.to_s} )"
        elsif multiplication? && f.inverse?(:*)
          "( #{g.to_s} / #{f.x.to_s} )"
        elsif addition? && g.inverse?(:+)
          "( #{f.to_s} - #{g.x.to_s} )"
        elsif addition? && f.inverse?(:+)
          "( #{g.to_s} - #{f.x.to_s} )"
        else
          "( #{f.to_s} #{@operator} #{g.to_s} )"
        end
      end

      def include?(x)
        f == x || g == x
      end

      def openable?(operator, x)
        distributive?(self.operator, operator) &&
        (f.combinable?(x, operator) || g.combinable?(x, operator))
      end

      # TODO: interchangeable
      def ==(x)
        to_s == x.to_s
      end

      def common_factors(formula)
        nil unless formula.is_a?(Formula)
        if f == formula.f
          [:f, :f]
        elsif g == formula.g
          [:g, :g]
        elsif f == formula.g
          [:f, :g]
        elsif g == formula.f
          [:g, :f]
        end
      end

      def commutate!
        @f, @g = @g, @f
        self
      end
    end
  end
end
