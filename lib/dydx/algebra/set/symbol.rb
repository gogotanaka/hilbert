module Dydx
  module Algebra
    module Set
      Symbol.class_eval do
        include Helper

        def differentiate(sym = :x)
          self == sym ? e1 : e0
        end
        alias_method :d, :differentiate
      end
    end
  end
end
