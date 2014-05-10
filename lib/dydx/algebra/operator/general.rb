require 'dydx/algebra/operator/common_parts'
require 'dydx/algebra/operator/parts/general'

module Dydx
  module Algebra
    module Operator
      module General
        include Parts::Base
        include Parts::General
        include Parts::Interface
      end
    end
  end
end
