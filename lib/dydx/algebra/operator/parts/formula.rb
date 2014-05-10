module Dydx
  module Algebra
    module Operator
      module Parts
        module Formula
          %w(+ -).each do |operator|
            define_method(operator) do |x|
              if multiplication? && x.multiplication?
                if f == x.f
                  f * g.send(operator, x.g)
                elsif g == x.g
                  f.send(operator, x.f) * g
                else
                  super(x)
                end
              else
                super(x)
              end
            end
          end

          %w(* /).each do |operator|
            define_method(operator) do |x|
              if exponentiation? && x.exponentiation?
                if f == x.f
                  f ^ g.send({'*'=>'+', '/'=>'-'}[operator], x.g)
                elsif g == x.g
                  f.send(operator, x.f) ^ g
                else
                  super(x)
                end
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
