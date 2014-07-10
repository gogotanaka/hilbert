module Dydx
  module Algebra
    module Operator
      module Parts
        module Base
          %w(+ * **).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              ::Algebra::Formula.new(operator.to_sym, self, x)
            end
          end
        end
      end
    end
  end
end
