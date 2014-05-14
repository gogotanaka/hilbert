module Dydx
  module Algebra
    module Operator
      module Parts
        module Formula
          %w(+ -).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if multiplication? && x.multiplication?
                if f == x.f
                  f * g.send(operator, x.g)
                elsif g == x.g
                  f.send(operator, x.f) * g
                else
                  super(x)
                end
              elsif ([self.operator, operator].sort == [:+, :-]) &&  include?(x)
                if f == x
                  g
                elsif g == x
                  f
                end
              elsif (self.operator == operator) && include?(x)
                if f == x
                  f.send(operator, x).send(operator, g)
                elsif g == x
                  f.send(operator, g.send(:+, x))
                end
              else
                super(x)
              end
            end
          end

          %w(* /).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if exponentiation? && x.exponentiation?
                if f == x.f
                  f ^ g.send({'*'=>'+', '/'=>'-'}[operator.to_s], x.g)
                elsif g == x.g
                  f.send(operator, x.f) ^ g
                else
                  super(x)
                end
              elsif ([self.operator, operator].sort == [:*, :/]) &&  include?(x)
                if f == x
                  g
                elsif g == x
                  f
                end
              elsif (self.operator == operator) && include?(x)
                if f == x
                  f.send(operator, x).send(operator, g)
                elsif g == x
                  f.send(operator, g.send(:* , x))
                end
              else
                super(x)
              end
            end
          end

          def ^(x)
            if (multiplication? || division?) && openable?(x)
              (f ^ x).send(self.operator, (g ^ x))
            else
              super(x)
            end
          end
        end
      end
    end
  end
end
