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
          f.d(sym) / (f)
        end
      end
    end
  end
end