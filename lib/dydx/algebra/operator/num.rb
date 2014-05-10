require 'dydx/operator/common_parts'
require 'dydx/operator/parts/num'

module Dydx
  module Operator
    module Num
      include Parts::Base
      include Parts::Num
      include Parts::General
      include Parts::Interface
    end
  end
  module Field
    class Num; include Operator::Num; end
  end
end