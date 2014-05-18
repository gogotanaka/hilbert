module Dydx
  module Algebra
    module Operator
      module Parts
        module Num
          def +(x)
            if n == 0
              x
            elsif x.is_a?(Num)
              _(n + x.n)
            elsif x.subtrahend? && x.x.is_a?(Num)
              _(n - x.x.n)
            else
              super(x)
            end
          end

          def *(x)
            if n == 0
              self
            elsif n == 1
              x
            elsif x.is_a?(Num)
              _(n * x.n)
            elsif x.divisor? && x.x.is_a?(Num)
              _(n / x.x.n)
            else
              super(x)
            end
          end

          def ^(x)
            if (n == 0) || (n == 1)
              self
            elsif x.is_a?(Num)
              _(n ^ x.n)
            else
              super(x)
            end
          end
        end
      end
    end
  end
end
