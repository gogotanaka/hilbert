module Dydx
  module Algebra
    module Set
      class Sin < Base
        attr_accessor :x

        def initialize(x)
          @x = x
        end

        def to_s
          "sin( #{x.to_s} )"
        end

        def d(sym=:x)
          cos(x) * x.d(sym)
        end
      end
    end
  end
end