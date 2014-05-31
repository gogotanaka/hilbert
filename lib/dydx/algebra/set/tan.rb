module Dydx
  module Algebra
    module Set
      class Tan < Base
        attr_accessor :x

        def initialize(x)
          @x = x
        end

        def to_s
          "tan( #{x} )"
        end
      end
    end
  end
end
