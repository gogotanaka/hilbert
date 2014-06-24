module Dydx
  module Algebra
    module Operator
      module Parts
        module Num
          %w(+ * **).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if x.is_a?(Num)
                _(n.send(operator, x.n))
              elsif operator == :+ && x.inverse?(:+) && x.x.is_a?(Num)
                _(n - x.x.n)
              elsif operator == :* && x.inverse?(:*) && x.x.is_a?(Num) && n % x.x.n == 0
                _(n / x.x.n)
              elsif zero?
                case operator
                when :+ then x
                when :* then e0
                when :** then e0
                end
              elsif one?
                case operator
                when :+ then super(x)
                when :* then x
                when :** then e1
                end
              else
                super(x)
              end
            end
          end

          def %(num)
            fail ArgumentError, "#{num} should be Num class object" unless num.is_a?(Num)
            _(n % num.n)
          end
        end
      end
    end
  end
end
