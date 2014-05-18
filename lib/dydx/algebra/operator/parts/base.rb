module Dydx
  module Algebra
    module Operator
      module Parts
        module Base
          %w(+ * ^).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if self == x && operator != :^
                case operator
                when :+
                  _(2) * self
                when :*
                  self ^ _(2)
                end
              elsif %w(+ *).map(&:to_sym).include?(operator) && x.send("#{to_str(operator)}?")
                if combinable?(x.f, operator)
                  send(operator, x.f).send(operator, x.g)
                elsif combinable?(x.g, operator)
                  send(operator, x.g).send(operator, x.f)
                else
                  ::Algebra::Formula.new(self, x, operator.to_sym)
                end
              elsif x.subtrahend? && %w(* ^).map(&:to_sym).include?(operator)
                inverse(::Algebra::Formula.new(self, x.x, operator.to_sym), :+)
              else
                ::Algebra::Formula.new(self, x, operator.to_sym)
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
