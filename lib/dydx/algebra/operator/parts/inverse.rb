module Dydx
  module Algebra
    module Operator
      module Parts
        module Inverse
          %w(+ * **).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if inverse?(operator, x)
                case operator
                when :+ then e0
                when :* then e1
                end
              elsif operator.eql?(:+) && !x.is_a?(Inverse)
                x + self
              elsif operator.eql?(:**) && self.operator.eql?(:*)
                inverse(self.x ** x, :*)
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
