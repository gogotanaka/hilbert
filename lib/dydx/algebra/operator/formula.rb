require 'dydx/algebra/operator/common_parts'
require 'dydx/algebra/operator/parts/formula'

module Dydx
  module Algebra
    module Operator
      module Formula
        include Parts::Base
        include Parts::Formula
        include Parts::General
        include Parts::Interface
      end
    end
  end
end
