require "dydx/operator/parts/base"
require "dydx/operator/parts/formula"
require "dydx/operator/parts/general"
require "dydx/operator/parts/interface"

module Dydx
  module Operator
    module Formula
      include Parts::Base
      include Parts::Formula
      include Parts::General
      include Parts::Interface
    end
  end
end