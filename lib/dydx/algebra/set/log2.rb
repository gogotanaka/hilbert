module Dydx
  module Algebra
    module Set
      class Log2 < Base
        attr_accessor :f

        def initialize(f)
          @f = f
        end

        def to_s
          "log2( #{f.to_s} )"
        end

        def differentiate(sym=:x)
          f.d(sym) / (f * log(2))
        end
        alias_method :d, :differentiate
      end
    end
  end
end
