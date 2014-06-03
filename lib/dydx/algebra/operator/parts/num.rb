module Dydx
  module Algebra
    module Operator
      module Parts
        module Num
          %w(+ * ^).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if zero?
                case operator
                when :+ then x
                when :* then e0
                when :^ then e0
                end
              elsif is_1?
                case operator
                when :+ then super(x)
                when :* then x
                when :^ then e1
                end
              elsif x.is_a?(Num)
                _(n.send(operator, x.n))
              elsif operator == :+ && x.inverse?(:+) && x.x.is_a?(Num)
                _(n - x.x.n)
              elsif operator == :* && x.inverse?(:*) && x.x.is_a?(Num)
                _(n / x.x.n)
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
