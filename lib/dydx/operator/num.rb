require "dydx/operator/parts/base"
require "dydx/operator/parts/num"
require "dydx/operator/parts/general"
require "dydx/operator/parts/interface"

module Dydx
  module Operator
    module Num
      include Operator::Parts::Base
      include Operator::Parts::Num
      include Operator::Parts::General
      include Operator::Parts::Interface
    end
  end
end