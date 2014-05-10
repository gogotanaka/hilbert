module Dydx
  module Field
    class Sin < Base
      attr_accessor :x

      def initialize(x)
        @x = x
      end

      def to_s
        "sin( #{x.to_s} )"
      end

      def d(sym=:x)
        cos(f) * f.d(sym)
      end
    end

    def sin(x)
      multiplier = x.is_multiple_of(pi)
      if multiplier.is_a?(Num)
        _(0)
      else
        Sin.new(x)
      end
    end
  end
end