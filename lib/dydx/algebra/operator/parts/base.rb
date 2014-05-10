module Dydx
  module Algebra
    module Operator
      module Parts
        module Base
          %w(+ - * / ^).each do |operator|
            define_method(operator) do |x|
              if self == x && operator != '^'
                case operator
                when '+'
                  _(2) * self
                when '-'
                  _(0)
                when '*'
                  self ^ _(2)
                when '/'
                  _(1)
                end
              else
                ::Algebra::Formula.new(self, x, operator.to_sym)
              end
            end
          end
        end
      end
    end
  end
end
