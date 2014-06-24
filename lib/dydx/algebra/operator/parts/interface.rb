module Dydx
  module Algebra
    module Operator
      module Parts
        module Interface
          %w(+ - * / ** %).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              x = _(x) if x.is_a?(Numeric)
              if operator == :/ && x.zero?
                fail ZeroDivisionError
              elsif [:-, :/].include?(operator)
                send(operator.inv, inverse(x, operator.inv))
              else
                super(x)
              end
            end
          end
        end
      end
    end
  end
end
