require 'dydx/algebra/formula'

require 'dydx/algebra/set'

require 'dydx/algebra/operator/formula'
require 'dydx/algebra/operator/symbol'
require 'dydx/algebra/operator/num'
require 'dydx/algebra/operator/general'

module Dydx
  module Algebra
    include Set
    module Set
      Symbol.class_eval{ include Operator::Symbol }
      Fixnum.class_eval do
        %w(+ - * / ^).each do |operator|
          define_method(operator) do |g|
            if g.is_a?(Symbol) ||
              g.is_a?(Formula) ||
              g.is_a?(Base)

              Num.new(self).send(operator.to_sym, g)
            else
              (to_f.send(operator.to_sym, g)).to_i
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
  end
end
