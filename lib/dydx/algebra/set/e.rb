module Dydx
  module Algebra
    module Set
      class E < Base
        def differentiate(sym=:x)
          e0
        end
        alias_method :d, :differentiate

        def to_s
          'e'
        end
      end
    end
  end
end
