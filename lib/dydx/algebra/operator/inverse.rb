require 'dydx/algebra/operator/common_parts'
require 'dydx/algebra/operator/parts/inverse'

module Dydx
  module Algebra
    module Operator
      module Inverse
        include Parts::Base
        include Parts::Inverse
        include Parts::General
        include Parts::Interface
      end
    end
  end
end
