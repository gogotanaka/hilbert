module Dydx
  module Algebra
    class Formula
      include Helper
      attr_accessor :operator, :terms

      def initialize(operator, *terms)
        @operator, @terms = operator, terms
        commutate! if (terms[1].num? && operator.commutative?)
      end

      def f
        @terms[0]
      end

      def g
        @terms[1]
      end

      def f=(x)
        @terms[0] = x
      end

      def g=(x)
        @terms[1] = x
      end

      def trs
        terms
      end

      # TODO: Cylomatic complexity for differentiate is too high. [7/6]
      def differentiate(sym = :x)
        case @operator
        when :+ then f.d(sym) + g.d(sym)
        when :* then (f.d(sym) * g) + (f * g.d(sym))
        when :**
          # TODO:
          if g.num?
            f.d(sym) * g * (f ** (g - 1))
          elsif f == sym
            g * (f ** (g - 1))
          elsif f == e
            g.d(sym) * self
          else
            self * (g * log(f)).d(sym)
          end
        end
      end
      alias_method :d, :differentiate

      def to_s
        if formula?(:*) && (f.minus1? || g.minus1?)
          "( - #{g} )"
        elsif g.inverse?(operator)
          "( #{f} #{operator.inv} #{g.x} )"
        elsif f.inverse?(operator)
          "( #{g} #{operator.inv} #{f.x} )"
        elsif formula?(:*) && !rationals.empty?
          terms = [f, g]
          terms.delete(rationals.first)
          "( #{(terms.first * rationals.first.n.numerator)} / #{rationals.first.n.denominator} )"
        else
          "( #{f} #{operator} #{g} )"
        end
      end

      def subst(hash = {})
        f.subst(hash).send(operator, g.subst(hash))
      end

      def to_f
        f.to_f.send(operator, g.to_f)
      end

      def include?(x)
        f == x || g == x
      end

      def openable?(operator, x)
        distributive?(self.operator, operator) &&
        (f.combinable?(x, operator) || g.combinable?(x, operator))
      end

      def rationals
        [f, g].select{ |term| term.num? && term.n.is_a?(Rational) }
      end

      def ==(x)
        if to_s == x.to_s
          true
        else
          result = commutate!.to_s == x.to_s
          commutate!
          result
        end
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
        @terms.reverse!
        self
      end

      def index(tr)
        trs.index(tr)
      end

      def delete(tr)
        trs.delete(tr)
        trs.count.one? ? trs.first : self
      end
    end
  end
end
