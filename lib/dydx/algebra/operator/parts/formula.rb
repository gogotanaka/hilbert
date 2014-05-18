module Dydx
  module Algebra
    module Operator
      module Parts
        module Formula
          %w(+ *).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if self.operator == operator
                if f.combinable?(x, operator)
                  f.send(operator, x).send(operator, g)
                elsif g.combinable?(x, operator)
                  g.send(operator, x).send(operator, f)
                else
                  super(x)
                end
              elsif operator == :+
                if multiplication? && x.multiplication?
                  if f == x.f
                    f * g.send(operator, x.g)
                  elsif f == x.g
                    f * g.send(operator, x.f)
                  elsif g == x.f
                    f.send(operator, x.g) * g
                  elsif g == x.g
                    f.send(operator, x.f) * g
                  else
                    super(x)
                  end
                # expect(((:b * :a) - (:c * :a)).to_s).to eq('( ( b - c ) * a )')
                elsif multiplication? && x.subtrahend? && x.x.multiplication?
                  if f == x.x.f
                    f * g.send(operator, inverse(x.x.g, :+))
                  elsif f == x.x.g
                    f * g.send(operator, inverse(x.x.f, :+))
                  elsif g == x.x.f
                    f.send(operator, inverse(x.x.g, :+)) * g
                  elsif g == x.x.g
                    f.send(operator, inverse(x.x.f, :+)) * g
                  else
                    super(x)
                  end
                else
                  super(x)
                end
              elsif operator == :*
                if exponentiation? && x.exponentiation?
                  if f == x.f
                    f ^ g.send(:+, x.g)
                  elsif g == x.g
                    f.send(operator, x.f) ^ g
                  else
                    super(x)
                  end
                elsif exponentiation? && x.divisor? && x.x.exponentiation?
                  if f == x.x.f
                    f ^ g.send(:-, x.x.g)
                  elsif g == x.x.g
                    f.send(:/, x.x.f) ^ g
                  else
                    super(x)
                  end
                # x * inverse(:y, :+)
                elsif x.subtrahend?
                  inverse(self * x.x, :+)
                elsif multiplication?
                  if f.combinable?(x, operator)
                    f.send(operator, x).send(operator, g)
                  elsif g.combinable?(x, operator)
                    g.send(operator, x).send(operator, f)
                  else
                    super(x)
                  end
                else
                  super(x)
                end
              end
            end
          end

          def ^(x)
            if multiplication? && openable?(x)
              (f ^ x).send(self.operator, (g ^ x))
            else
              super(x)
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
