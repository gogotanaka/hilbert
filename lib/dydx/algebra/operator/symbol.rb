require 'dydx/algebra/operator/common_parts'
require 'dydx/algebra/operator/parts/symbol'

module Dydx
  module Algebra
    module Operator
      module Symbol
        include Parts::Base
        include Parts::Symbol
        include Parts::General
        include Parts::Interface
      end
    end
  end
end