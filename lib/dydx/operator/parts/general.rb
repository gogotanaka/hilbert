module Dydx
  module Operator
    module Parts
      module General
        def +(x)
          if x.is_a?(Num) && x.n ==0
            self
          else
            super(x)
          end
        end

        def -(x)
          if x.is_a?(Num) && x.n ==0
            self
          else
            super(x)
          end
        end

        def *(x)
          if x.is_a?(Num) && x.n ==0
            x
          elsif x.is_a?(Num) && x.n ==1
            self
          else
            super(x)
          end
        end

        def /(x)
          if x.is_a?(Num) && x.n ==0
            raise ZeroDivisionError
          elsif x.is_a?(Num) && x.n ==1
            self
          else
            super(x)
          end
        end

        def ^(x)
          if x.is_a?(Num) && x.n ==0
            _(1)
          elsif x.is_a?(Num) && x.n ==1
            self
          else
            super(x)
          end
        end
      end
    end
  end
end