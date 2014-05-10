module Dydx
  module Algebra
    module Set
      class Cos < Base
        attr_accessor :x

        def initialize(x)
          @x = x
        end

        def to_s
          "cos( #{x.to_s} )"
        end

        def d(sym=:x)
          -1 * sin(x) * x.d(sym)
        end
      end
    end
  end
end