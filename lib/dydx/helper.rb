module Dydx
  module Helper
    OP_SYM_STR = {
      addition:       :+,
      multiplication: :*,
      exponentiation: :^
    }

    SUPER_OPE_RELATION = {
      :+ => :*,
      :- => :/,
      :* => :^,
      :/ => :|
    }

    INVERSE_OPE_RELATION = {
      :+ => :-,
      :- => :+,
      :* => :/,
      :/ => :*,
      :^ => :|,
      :| => :^
    }

    def super_ope(operator)
      SUPER_OPE_RELATION[operator]
    end

    def sub_ope(operator)
      SUPER_OPE_RELATION.invert[operator]
    end

    def inverse_ope(operator)
      INVERSE_OPE_RELATION[operator]
    end

    def inverse_super_ope(operator)
      inverse_ope(super_ope(operator))
    end

    def is_num?
      (is_a?(Num) || is_a?(Fixnum)) || (is_a?(Inverse) && x.is_num?)
    end

    def is_0?
      self == 0 || (is_a?(Num) && n == 0)
    end

    def is_1?
      self == 1 || (is_a?(Num) && n == 1)
    end

    def is_minus1?
      self == -1 || (is_a?(Num) && n == -1)
    end

    def distributive?(ope1, ope2)
      [super_ope(ope1), inverse_super_ope(ope1)].include?(ope2)
    end

    def combinable?(x, operator)
      case operator
      when :+
        self == x ||
        (is_num? && x.is_num?) ||
        (multiplication? && (f == x || g == x)) ||
        (x.multiplication? && (x.f == self || x.g == self)) ||
        inverse?(x, :+)
      when :*
        self == x ||
        (is_num? && x.is_num?) ||
        inverse?(x, :*)
      when :^
        (is_num? && x.is_num?) || is_0? || is_1?
      end
    end

    def is_multiple_of(x)
      if is_0?
        e0
      elsif self == x
        e1
      # elsif is_num? && x.is_num? && (self % x == 0)
      #   _(n / x.n)
      elsif multiplication? && (f == x || g == x)
        f == x ? g : f
      else
        false
      end
    end

    OP_SYM_STR.each do |operator_name, operator|
      define_method("#{operator_name}?") do
        is_a?(Formula) && (@operator == operator)
        # is_a?(Inverse) && self.operator == operator
      end
    end

    def to_str(sym)
      OP_SYM_STR.key(sym)
    end

    def str_to_sym(str)
      OP_SYM_STR[str]
    end

    def to_str_inv(operator)
      {
        subtrahend: :+,
        divisor:    :*
      }.key(operator)
    end

    def rest(f_or_g)
      ([:f, :g] - [f_or_g]).first
    end

    def commutative?(operator)
      [:+, :*].include?(operator)
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

    def formula?(operator)
      is_a?(Formula) && (@operator == operator)
    end
  end
end
