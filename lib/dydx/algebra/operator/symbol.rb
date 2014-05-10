require 'dydx/operator/common_parts'
require 'dydx/operator/parts/symbol'

module Dydx
  module Operator
    module Symbol
      include Parts::Base
      include Parts::Symbol
      include Parts::General
      include Parts::Interface
    end
  end

  module Field
    Symbol.class_eval{ include Operator::Symbol }
  end
end