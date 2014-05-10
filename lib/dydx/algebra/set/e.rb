module Dydx
  module Algebra
    module Set
      class E < Base
        def differentiate(sym=:x)
          _(0)
        end
        alias_method :d, :differentiate

        def to_s
          'e'
        end
      end
    end
  end
end