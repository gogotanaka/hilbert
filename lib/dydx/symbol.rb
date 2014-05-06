require "dydx/operator/base"
require "dydx/operator/general"
require "dydx/operator/interface"
require "dydx/operator/num"

module Dydx
  Symbol.class_eval do
    include Operator::Base
    include Operator::General
    include Operator::Interface

    def d(sym=:x)
      self == sym ? _(1) : _(0)
    end
  end
end