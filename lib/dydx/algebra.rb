require 'dydx/algebra/set'

module Dydx
  module Algebra
    include Set

    class Formula;  include Operator::Formula; end
    class Inverse;  include Operator::Inverse; end

    # TODO: Cyclomatic complexity for inverse is too high. [7/6]
    def inverse(x, operator)
      if operator == :+ && x.zero?
        e0
      elsif operator == :* && x.one?
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
