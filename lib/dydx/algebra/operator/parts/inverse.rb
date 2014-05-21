module Dydx
  module Algebra
    module Operator
      module Parts
        module Inverse
          %w(+ * ^).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if inverse?(operator, x)
                case operator
                when :+ then e0
                when :* then e1
                end
              elsif !x.is_a?(Inverse) && operator == :+
                x + self
              elsif self.operator == :* && operator == :^
                inverse(self.x ^ x, :*)
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
