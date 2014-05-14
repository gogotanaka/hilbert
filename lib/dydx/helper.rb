module Dydx
  module Helper
    OP_SYM_STR = {
      addition:       :+,
      subtraction:    :-,
      multiplication: :*,
      division:       :/,
      exponentiation: :^
    }

    def is_0?
      self == 0 || (is_a?(Num) && n == 0)
    end

    def is_1?
      self == 1 || (is_a?(Num) && n == 1)
    end

    def is_minus1?
      self == -1 || (is_a?(Num) && n == -1)
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
      define_method("#{operator_name}?") { @operator == operator }
    end

    def sym_to_str(sym)
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
  end
end