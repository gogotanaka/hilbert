module Dydx
  module Algebra
    module Set
      class Cos < Base
        attr_accessor :x

        def initialize(x)
          @x = x
        end

        def to_s
          "cos( #{x} )"
        end

        def differentiate(sym = :x)
          -1 * sin(x) * x.d(sym)
        end
        alias_method :d, :differentiate
      end
    end
  end
end
