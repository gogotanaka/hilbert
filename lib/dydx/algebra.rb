require 'dydx/algebra/formula'

require 'dydx/algebra/set/base'
require 'dydx/algebra/set/num'
require 'dydx/algebra/set/fixnum'
require 'dydx/algebra/set/symbol'
require 'dydx/algebra/set/e'
require 'dydx/algebra/set/pi'
require 'dydx/algebra/set/log'
require 'dydx/algebra/set/sin'
require 'dydx/algebra/set/cos'
require 'dydx/algebra/set/tan'

require 'dydx/algebra/operator/formula'
require 'dydx/algebra/operator/symbol'
require 'dydx/algebra/operator/num'
require 'dydx/algebra/operator/general'

module Dydx
  module Algebra
    include Set
    module Set
      Symbol.class_eval{ include Operator::Symbol }
      class Num;    include Operator::Num; end
      class E;      include Operator::General; end
      class Pi;     include Operator::General; end
      class Log;    include Operator::General; end
      class Sin;    include Operator::General; end
      class Cos;    include Operator::General; end
      class Tan;    include Operator::General; end
    end
    class Formula;  include Operator::Formula; end

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

    def log(formula)
      if formula.multiplication?
        f, g = formula.f, formula.g
        log(f) + log(g)
      elsif formula.exponentiation?
        f, g = formula.f, formula.g
        g * log(f)
      elsif formula.is_1?
        _(0)
      elsif formula.is_a?(E)
        _(1)
      else
        Log.new(formula)
      end
    end

    def sin(x)
      multiplier = x.is_multiple_of(pi)
      if multiplier.is_a?(Num)
        _(0)
      else
        Sin.new(x)
      end
    end

    def cos(x)
      multiplier = x.is_multiple_of(pi)
      if multiplier.is_a?(Num) && multiplier.n % 2 == 0
        _(1)
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
