module Dydx
  module Operator
    module Base
      %w(+ - * / ^).each do |operator|
        define_method(operator) do |x|
          ::Formula.new(self, x, operator.to_sym)
        end
      end
    end
  end
end