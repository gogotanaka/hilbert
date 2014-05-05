module Dydx
  class Log
    # include Operator::Base
    # include Operator::General
    # include Operator::Interface

    attr_accessor :f

    def initialize(f)
      @f = f
    end

    def d(sym=:x)
      f.d(sym) / (f)
    end

    def to_s
      "log( #{f.to_s} )"
    end
  end

  def log(formula)
    if formula.is_a?(Formula) && formula.multiplication?
      f, g = formula.f, formula.g
      log(f) + log(g)
    elsif formula.is_a?(Formula) && formula.exponentiation?
      f, g = formula.f, formula.g
      g * log(f)
    elsif formula.is_a?(E)
      _(1)
    else
      Log.new(formula)
    end
  end
end
