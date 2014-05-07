module Dydx
  Symbol.class_eval do
    include Operator::General

    include Helper

    def differentiate(sym=:x)
      self == sym ? _(1) : _(0)
    end
    alias_method :d, :differentiate
  end
end