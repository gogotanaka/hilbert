require 'dydx/algebra/formula'
require 'dydx/algebra/inverse'

require 'dydx/algebra/set'

require 'dydx/algebra/operator/inverse'
require 'dydx/algebra/operator/formula'
require 'dydx/algebra/operator/symbol'
require 'dydx/algebra/operator/num'
require 'dydx/algebra/operator/general'

module Dydx
  module Algebra
    include Set
    module Set
      # TODO: Refactor
      Symbol.class_eval{ include Operator::Symbol }
      Fixnum.class_eval do
        %w(+ - * / ^).each do |operator|
          define_method(operator) do |g|
            if g.is_a?(Symbol) ||
              g.is_a?(Formula) ||
              g.is_a?(Base)

              Num.new(self).send(operator.to_sym, g)
            elsif operator == '^' && g.is_a?(Fixnum) || g.is_a?(Float)
              self ** g
            elsif operator == '^' && g.is_a?(Num)
              self ** g.n
            else
              (to_f.send(operator.to_sym, g)).to_i
            end
          end
        end
      end
      Float.class_eval do
        %w(^).each do |operator|
          define_method(operator) do |g|
            if g.is_a?(Fixnum) || g.is_a?(Float)
              self ** g
            elsif g.is_a?(Num)
              self ** g.n
            else
              Num.new(self).send(operator.to_sym, g)
            end
          end
        end
      end
      class Num;    include Operator::Num; end
      class E;      include Operator::General; end
      class Pi;     include Operator::General; end
      class Log;    include Operator::General; end
      class Sin;    include Operator::General; end
      class Cos;    include Operator::General; end
      class Tan;    include Operator::General; end
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
