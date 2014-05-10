module Dydx
  module Algebra
    module Set
      Symbol.class_eval do
        include Helper

        def differentiate(sym=:x)
          self == sym ? _(1) : _(0)
        end
        alias_method :d, :differentiate
      end
    end
  end
end