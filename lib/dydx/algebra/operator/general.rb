require 'dydx/operator/common_parts'
require 'dydx/operator/parts/general'

module Dydx
  module Operator
    module General
      include Parts::Base
      include Parts::General
      include Parts::Interface
    end
  end

  module Field
    class E;      include Operator::General; end
    class Pi;     include Operator::General; end
    class Log;    include Operator::General; end
    class Sin;    include Operator::General; end
    class Cos;    include Operator::General; end
    class Tan;    include Operator::General; end
  end
end