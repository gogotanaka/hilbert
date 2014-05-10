module Dydx
  module Algebra
    module Operator
      module Parts
        module Formula
          def *(x)
            if exponentiation? &&
              x.exponentiation? &&
              f == x.f

              f ^ (g + x.g)
            else
              super(x)
            end
          end

          def /(x)
            if exponentiation? &&
              x.exponentiation? &&
              f == x.f

              f ^ (g - x.g)
            else
              super(x)
            end
          end
        end
      end
    end
  end
end
