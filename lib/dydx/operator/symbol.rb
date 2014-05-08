require "dydx/operator/parts/base"
require "dydx/operator/parts/formula"
require "dydx/operator/parts/symbol"
require "dydx/operator/parts/interface"

module Dydx
  module Operator
    module Symbol
      include Parts::Base
      include Parts::Symbol
      include Parts::General
      include Parts::Interface
    end
  end
end