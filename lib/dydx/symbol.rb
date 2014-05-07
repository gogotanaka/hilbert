module Dydx
  Symbol.class_eval do
    include Operator::General

    include Helper

    def d(sym=:x)
      self == sym ? _(1) : _(0)
    end
  end
end