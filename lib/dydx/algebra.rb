require 'dydx/algebra/set'
require 'dydx/algebra/formula'
require 'dydx/algebra/inverse'

module Dydx
  module Algebra
    include Set
    module Set
      # TODO: Refactor
      Fixnum.class_eval do
        alias_method :addition, :+
        alias_method :subtraction, :-
        alias_method :multiplication, :*
        alias_method :division, :/
        alias_method :exponentiation, :**
        ope_to_str = {
          addition: :+,
          subtraction: :-,
          multiplication: :*,
          division: :/,
          exponentiation: :^
        }
        %w(+ - * / ^).each do |operator|
          define_method(operator) do |g|
            if g.is_a?(Symbol) ||
              g.is_a?(Formula) ||
              g.is_a?(Base)

              Num.new(self).send(operator.to_sym, g)
            else
              send(ope_to_str.key(operator.to_sym), g)
            end
          end
        end
      end

      Float.class_eval do
        alias_method :addition, :+
        alias_method :subtraction, :-
        alias_method :multiplication, :*
        alias_method :division, :/
        alias_method :exponentiation, :**
        ope_to_str = {
          addition: :+,
          subtraction: :-,
          multiplication: :*,
          division: :/,
          exponentiation: :^
        }
        %w(+ - * / ^).each do |operator|
          define_method(operator) do |g|
            if g.is_a?(Symbol) ||
              g.is_a?(Formula) ||
              g.is_a?(Base)

              Num.new(self).send(operator.to_sym, g)
            else
              send(ope_to_str.key(operator.to_sym), g)
            end
          end
        end
      end
    end
    class Formula;  include Operator::Formula; end
    class Inverse;  include Operator::Inverse; end

    def inverse(x, operator)
      if operator == :+ && x.is_0?
        e0
      elsif operator == :* && x.is_1?
        e1
      elsif x.is_a?(Inverse) && x.operator == operator
        x.x
      else
        Inverse.new(x, operator)
      end
    end

    def -@
      inverse(self, :+)
    end
  end
end
