module Dydx
  module Helper
    OP_SYM_STR = {
      addition:       :+,
      subtraction:    :-,
      multiplication: :*,
      exponentiation: :^
    }

    def is_0?
      self == 0 || (is_a?(Num) && n == 0) || (subtrahend? && x.is_0?)
    end

    def is_1?
      self == 1 || (is_a?(Num) && n == 1) || (divisor? && x.is_1?)
    end

    def is_minus1?
      self == -1 || (is_a?(Num) && n == -1)
    end

    def is_num?
      if is_a?(Inverse)
        x.is_num?
      else
        is_a?(Num) || is_a?(Fixnum)
      end
    end

    def combinable?(x, operator)
      case operator
      when :*
        self == x ||
        (is_num? && x.is_num?) ||
        inverse?(x, :*)
      when :+
        like_term?(x)
      end
    end

    def like_term?(x)
      self == x ||
      (is_num? && x.is_num?) ||
      (multiplication? && (f == x || g == x)) ||
      inverse?(x, :+)
    end

    def is_multiple_of(x)
      is_multiple = if is_0?
        _(0)
      elsif self == x
        _(1)
      elsif is_a?(Formula) &&
        (f == x || g == x)
        f == x ? g : f
      else
        false
      end
    end

    OP_SYM_STR.each do |operator_name, operator|
      define_method("#{operator_name}?") do
        (@operator == operator) && is_a?(Formula)
        # is_a?(Inverse) && self.operator == operator
      end
    end

    def to_str(sym)
      OP_SYM_STR.key(sym)
    end

    def str_to_sym(str)
      OP_SYM_STR[str]
    end

    def super_ope(operator)
      case operator
      when :+
        :*
      when :-
        :/
      when :*
        :^
      end
    end

    def inverse?(x, operator)
      if is_a?(Algebra::Inverse)
        self.operator == operator && self.x == x
      elsif x.is_a?(Algebra::Inverse)
        self == x.x
      else
        false
      end
    end

    def subtrahend?
       is_a?(Inverse) && operator == :+
    end

    def divisor?
       is_a?(Inverse) && operator == :*
    end
  end
end