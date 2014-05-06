require "dydx/operator/parts/base"
require "dydx/operator/parts/general"
require "dydx/operator/parts/interface"

module Dydx
  module Operator
    module General
      include Parts::Base
      include Parts::General
      include Parts::Interface
    end
  end
end