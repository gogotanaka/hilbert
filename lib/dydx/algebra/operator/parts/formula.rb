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
              elsif formula?(sub_ope(operator)) && openable?(operator, x)
                f.send(operator, x).send(sub_ope(operator), g.send(operator, x))
              elsif formula?(super_ope(operator)) && x.formula?(super_ope(operator))
                w1, w2 = common_factors(x)
                return super(x) unless (w1 && w2) && (super_ope(operator).commutative? || w1 == w2)

                case operator
                when :+
                  send(w1).send(super_ope(operator), send(rest(w1)).send(operator, x.send(rest(w2))))
                when :*
                  case w1
                  when :f
                    send(w1).send(super_ope(operator), send(rest(w1)).send(sub_ope(operator), x.send(rest(w2))))
                  when :g
                    send(w1).send(super_ope(operator), send(rest(w1)).send(operator, x.send(rest(w2)))).commutate!
                  end
                end
              elsif formula?(super_ope(operator)) && x.inverse?(operator) && x.x.formula?(super_ope(operator))
                w1, w2 = common_factors(x.x)
                return super(x) unless (w1 && w2) && (super_ope(operator).commutative? || w1 == w2)

                case operator
                when :+
                  send(w1).send(super_ope(operator), send(rest(w1)).send(inverse_ope(operator), x.x.send(rest(w2))))
                when :*
                  case w1
                  when :f
                    send(w1).send(super_ope(operator), send(rest(w1)).send(inverse_ope(sub_ope(operator)), x.x.send(rest(w2))))
                  when :g
                    send(w1).send(super_ope(operator), send(rest(w1)).send(inverse_ope(operator), x.x.send(rest(w2)))).commutate!
                  end
                end
              else
                super(x)
              end
            end
          end

          %w(^).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if formula?(sub_ope(operator)) && openable?(operator, x)
                f.send(operator, x).send(sub_ope(operator), g.send(operator, x))
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
