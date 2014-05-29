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
              elsif formula?(operator.sub) && openable?(operator, x)
                f.send(operator, x).send(operator.sub, g.send(operator, x))
              elsif formula?(operator.super) && x.formula?(operator.super)
                w1, w2 = common_factors(x)
                return super(x) unless (w1 && w2) && (operator.super.commutative? || w1 == w2)

                case operator
                when :+
                  send(w1).send(operator.super, send(rest(w1)).send(operator, x.send(rest(w2))))
                when :*
                  case w1
                  when :f
                    send(w1).send(operator.super, send(rest(w1)).send(operator.sub, x.send(rest(w2))))
                  when :g
                    send(w1).send(operator.super, send(rest(w1)).send(operator, x.send(rest(w2)))).commutate!
                  end
                end
              elsif formula?(operator.super) && x.inverse?(operator) && x.x.formula?(operator.super)
                w1, w2 = common_factors(x.x)
                return super(x) unless (w1 && w2) && (operator.super.commutative? || w1 == w2)

                case operator
                when :+
                  send(w1).send(operator.super, send(rest(w1)).send(inverse_ope(operator), x.x.send(rest(w2))))
                when :*
                  case w1
                  when :f
                    send(w1).send(operator.super, send(rest(w1)).send(inverse_ope(operator.sub), x.x.send(rest(w2))))
                  when :g
                    send(w1).send(operator.super, send(rest(w1)).send(inverse_ope(operator), x.x.send(rest(w2)))).commutate!
                  end
                end
              else
                super(x)
              end
            end
          end

          %w(^).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              if formula?(operator.sub) && openable?(operator, x)
                f.send(operator, x).send(operator.sub, g.send(operator, x))
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
