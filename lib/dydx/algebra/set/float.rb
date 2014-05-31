module Dydx
  module Algebra
    module Set
      Float.class_eval do
        include Helper

        def differentiate(_sym = :x)
          e0
        end
        alias_method :d, :differentiate
      end
    end
  end
end
