require 'dydx/operator/symbol'

module Dydx
  Symbol.class_eval do
    include Operator::Symbol

    include Helper

    def differentiate(sym=:x)
      self == sym ? _(1) : _(0)
    end
    alias_method :d, :differentiate
  end
end