module Dydx
  module Algebra
    module Operator
      module Parts
        module General
          def +(x)
            if x.is_0?
              self
            else
              super(x)
            end
          end

          def -(x)
            if x.is_0?
              self
            else
              super(x)
            end
          end

          def *(x)
            if x.is_0?
              x
            elsif x.is_1?
              self
            else
              super(x)
            end
          end

          def /(x)
            if x.is_0?
              raise ZeroDivisionError
            elsif x.is_1?
              self
            else
              super(x)
            end
          end

          def ^(x)
            if x.is_0?
              _(1)
            elsif x.is_1?
              self
            else
              super(x)
            end
          end
        end
      end
    end
  end
end
