module Dydx
  module Algebra
    module Set
      class Log10 < Base
        attr_accessor :f

        def initialize(f)
          @f = f
        end

        def to_s
          "log10( #{f.to_s} )"
        end

        def differentiate(sym=:x)
          f.d(sym) / (f * log(10))
        end
        alias_method :d, :differentiate
      end
    end
  end
end
