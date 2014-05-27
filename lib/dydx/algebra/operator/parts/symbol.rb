module Dydx
  module Algebra
    module Operator
      module Parts
        module Symbol
          def *(x)
            if x.formula?(:^) &&
              self == x.f

              self ^ (1 + x.g)
            else
              super(x)
            end
          end
        end
      end
    end
  end
end
