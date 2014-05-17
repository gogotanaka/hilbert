module Dydx
  module Algebra
    module Operator
      module Parts
        module Inverse
          def +(x)
            if self.x == x && operator == :+
              e0
            elsif !x.is_a?(Inverse)
              x + self
            else
              super()
            end
          end

          def *(x)
            if self.x == x && operator == :*
              e1
            else
              super(x)
            end
          end
        end
      end
    end
  end
end
