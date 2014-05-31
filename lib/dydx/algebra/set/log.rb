module Dydx
  module Algebra
    module Set
      class Log < Base
        attr_accessor :f

        def initialize(f)
          @f = f
        end

        def differentiate(sym = :x)
          f.d(sym) / (f)
        end
        alias_method :d, :differentiate

        def to_s
          "log( #{f} )"
        end
      end
    end
  end
end
