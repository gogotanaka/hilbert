require 'dydx/algebra/operator/parts'
require 'dydx/algebra/operator/inverse'
require 'dydx/algebra/operator/formula'
require 'dydx/algebra/operator/num'
require 'dydx/algebra/operator/general'

module Dydx
  module Algebra
    module Set
      module Base
        include Helper
        def self.included(klass)
          klass.class_eval do
            if klass == Num
              attr_accessor :n
            else
              attr_accessor :x
            end
          end
          alias_method :d, :differentiate
        end

        def initialize(x=nil)
          case self
          when Num
            @n = x
          when Sin, Cos, Tan, Log, Log10, Log2
            @x = x
          end
        end

        def to_s
          case self
          when Num   then n.to_s
          when Pi    then 'pi'
          when E     then 'e'
          when Sin   then "sin( #{x.to_s} )"
          when Cos   then "cos( #{x.to_s} )"
          when Tan   then "tan( #{x.to_s} )"
          when Log   then "log( #{x.to_s} )"
          when Log10 then "log10( #{x.to_s} )"
          when Log2  then "log2( #{x.to_s} )"
          end
        end

        def to_f
          case self
          when Num    then n.to_f
          when Pi     then Math::PI
          when E      then Math::E
          when Symbol then raise ArgumentError
          when Sin    then Math.sin(x.to_f)
          when Cos    then Math.cos(x.to_f)
          when Tan    then Math.tan(x.to_f)
          when Log    then Math.log(x.to_f)
          when Log10  then Math.log(x.to_f, 10)
          when Log2   then Math.log(x.to_f, 2)
          end
        end

        def subst(hash = {})
          case self
          when Num, Pi, E
            self
          when Symbol
            hash[self] || self
          when Sin, Cos, Tan, Log, Log10, Log2
            @x = @x.subst(hash)
            self
          end
        end

        def differentiate(sym = :x)
          case self
          when Num, Pi, E then e0
          when Symbol     then self == sym ? e1 : e0
          when Sin        then cos(x) * x.d(sym)
          when Cos        then -1 * sin(x) * x.d(sym)
          when Tan        then 1 / (cos(x) ** 2)
          when Log        then x.d(sym) / (x)
          when Log10      then x.d(sym) / (x * log(10))
          when Log2       then x.d(sym) / (x * log(2))
          end
        end
      end

      class Num
        include Base
        include Operator::Num;
      end

      class Pi
        include Base
        include Operator::General;
      end

      class E
        include Base
        include Operator::General;
      end

      class Sin
        include Base
        include Operator::General;
      end

      class Cos
        include Base
        include Operator::General;
      end

      class Tan
        include Base
        include Operator::General;
      end

      class Log
        include Base
        include Operator::General;
      end

      class Log10
        include Base
        include Operator::General;
      end

      class Log2
        include Base
        include Operator::General;
      end

      Symbol.class_eval do
        include Base
        include Operator::General
      end

      Fixnum.class_eval do
        include Helper

        def differentiate(sym=:x)
          e0
        end
        alias_method :d, :differentiate
      end

      Float.class_eval do
        include Helper

        def differentiate(sym=:x)
          e0
        end
        alias_method :d, :differentiate
      end

      def e0
        eval("$e0 ||= Num.new(0)")
      end

      def e1
        eval("$e1 ||= Num.new(1)")
      end
      def _(num)
        if num >= 0
          eval("$p#{num} ||= Num.new(num)")
        else
          eval("$n#{-1 * num} ||= Num.new(num)")
        end
      end

      def pi
        $pi ||= Pi.new
      end

      def e
        $e ||= E.new
      end

      def oo
        Float::INFINITY
      end

      def log(formula)
        if formula.multiplication?
          f, g = formula.f, formula.g
          log(f) + log(g)
        elsif formula.exponentiation?
          f, g = formula.f, formula.g
          g * log(f)
        elsif formula.is_1?
          e0
        elsif formula.is_a?(E)
          e1
        else
          Log.new(formula)
        end
      end

      def log2(formula)
        # TODO: refactor with log function.
        if formula.multiplication?
          f, g = formula.f, formula.g
          log2(f) + log2(g)
        elsif formula.exponentiation?
          f, g = formula.f, formula.g
          g * log2(f)
        elsif formula.is_1?
          e0
        elsif formula.is_a?(Num)
          (formula.n == 2) ? e1 : log2(formula.n)
        elsif formula == 2
          e1
        else
          Log2.new(formula)
        end
      end

      def log10(formula)
        # TODO: refactor with log function.
        if formula.multiplication?
          f, g = formula.f, formula.g
          log10(f) + log10(g)
        elsif formula.exponentiation?
          f, g = formula.f, formula.g
          g * log10(f)
        elsif formula.is_1?
          e0
        elsif formula.is_a?(Num)
          (formula.n == 10) ? e1 : log10(formula.n)
        elsif formula == 10
          e1
        else
          Log10.new(formula)
        end
      end

      def sin(x)
        multiplier = x.is_multiple_of(pi)
        if multiplier.is_a?(Num)
          e0
        else
          Sin.new(x)
        end
      end

      def cos(x)
        multiplier = x.is_multiple_of(pi)
        if multiplier.is_a?(Num) && multiplier.n % 2 == 0
          e1
        elsif multiplier.is_a?(Num) && multiplier.n % 2 == 1
          _(-1)
        else
          Cos.new(x)
        end
      end

      def tan(x)
        Tan.new(x)
      end
    end
  end
end
