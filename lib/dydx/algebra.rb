require 'dydx/algebra/set'
require 'dydx/algebra/formula'
require 'dydx/algebra/inverse'

module Dydx
  module Algebra
    include Set

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
