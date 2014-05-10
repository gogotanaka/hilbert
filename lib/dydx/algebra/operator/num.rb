require 'dydx/algebra/operator/common_parts'
require 'dydx/algebra/operator/parts/num'

module Dydx
  module Algebra
    module Operator
      module Num
        include Parts::Base
        include Parts::Num
        include Parts::General
        include Parts::Interface
      end
    end
  end
end
