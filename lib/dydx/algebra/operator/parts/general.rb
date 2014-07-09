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

        module Associative
          %w(+ * **).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if operator.associative?
                if x.formula?(operator)
                  if combinable?(x.f, operator)
                    send(operator, x.f).send(operator, x.g)
                  elsif combinable?(x.g, operator)
                    send(operator, x.g).send(operator, x.f)
                  else
                    super(x)
                  end
                elsif x.is_a?(Inverse) && x.operator == operator && x.x.formula?(operator)
                  if combinable?(x.x.f, operator)
                    send(operator, inverse(x.x.f, operator)).send(operator, inverse(x.x.g, operator))
                  elsif combinable?(x.x.g, operator)
                    send(operator, inverse(x.x.g, operator)).send(operator, inverse(x.x.f, operator))
                  else
                    super(x)
                  end
                else
                  super(x)
                end
              else
                super(x)
              end
            end
          end
        end

        module General1
          %w(+ * **).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if x.zero?
                case operator
                when :+  then self
                when :*  then x
                when :** then e1
                end
              elsif x.one?
                case operator
                when :+  then super(x)
                when :*  then self
                when :** then self
                end
              elsif self == x
                case operator
                when :+  then _(2) * self
                when :*  then self ** _(2)
                when :** then super(x)
                end
              elsif inverse?(operator, x)
                case operator
                when :+ then e0
                when :* then e1
                end
              elsif [:+, :*].include?(operator)
                if x.formula?(operator.super) && self == x.f
                  send(operator.super, (1 + x.g))
                else
                  super(x)
                end
              else
                super(x)
              end
            end
          end
        end

        module General2
          %w(+ * **).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if operator == :* && x.inverse?(:+)
                -(self * x.x)
              else
                super(x)
              end
            end
          end
        end

        module General
          include General2
          include General1
          include Associative
          include Interface
        end
      end
    end
  end
end
