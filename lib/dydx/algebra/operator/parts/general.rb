module Dydx
  module Algebra
    module Operator
      module Parts
        module General
          %w(+ * ^).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if x.is_0?
                case operator
                when :+ then self
                when :* then x
                when :^ then e1
                end
              elsif x.is_1?
                case operator
                when :+ then super(x)
                when :* then self
                when :^ then self
                end
              elsif self == x
                case operator
                when :+ then _(2) * self
                when :* then self ^ _(2)
                when :^ then super(x)
                end
              elsif operator == :+ && inverse?(x, :+)
                e0
              elsif operator == :* && inverse?(x, :*)
                e1
              elsif [:+, :*].include?(operator) && x.send("#{to_str(operator)}?")
                if combinable?(x.f, operator)
                  send(operator, x.f).send(operator, x.g)
                elsif combinable?(x.g, operator)
                  send(operator, x.g).send(operator, x.f)
                else
                  super(x)
                end
              elsif [:*].include?(operator) && x.subtrahend?
                inverse(::Algebra::Formula.new(self, x.x, operator.to_sym), :+)
              else
                super(x)
              end
            end
          end

          def to_str(operator)
            {
              addition:       :+,
              multiplication: :*,
              exponentiation: :^
            }.key(operator)
          end
        end
      end
    end
  end
end
