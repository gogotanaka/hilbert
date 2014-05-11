module Dydx
  module Algebra
    module Set
      Fixnum.class_eval do
        include Helper

        def differentiate(sym=:x)
          _(0)
        end
        alias_method :d, :differentiate
      end
    end
  end
end
