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

        def differentiate(sym=:x)
          cos(x) * x.d(sym)
        end
        alias_method :d, :differentiate
      end
    end
  end
end
