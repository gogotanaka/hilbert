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
      (is_a?(Num) || is_a?(Fixnum) || is_a?(Float)) || (is_a?(Inverse) && x.is_num?)
    end

    def is_0?
      [0, 0.0].include?(self) || (is_a?(Num) && n.is_0?)
    end

    def is_1?
      [1, 1.0].include?(self) || (is_a?(Num) && n.is_1?)
    end

    def is_minus1?
      [1, -1.0].include?(self)|| (is_a?(Num) && n.is_minus1?)
    end

    def distributive?(ope1, ope2)
      [super_ope(ope1), inverse_super_ope(ope1)].include?(ope2)
    end

    def combinable?(x, operator)
      case operator
      when :+
        (is_num? && x.is_num?) ||
        like_term?(x) ||
        inverse?(:+, x)
      when :*
        self == x ||
        (is_num? && x.is_num?) ||
        inverse?(:*, x)
      when :^
        (is_num? && x.is_num?) || is_0? || is_1?
      end
    end

    def like_term?(x)
      boolean = if self == x
      elsif formula?(:*) && include?(x)
      elsif x.formula?(:*) && x.include?(self)
      elsif ((formula?(:*) && formula?(:*)) && (([f, g] & [x.f, x.g]).any?{|x| x.is_a?(Symbol)}))
      else
        true
      end

     !boolean
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

    def rest(f_or_g)
      ([:f, :g] - [f_or_g]).first
    end

    def commutative?
    end

    def distributable?(operator)
    end

    def inverse?(operator, x=nil)
      if is_a?(Algebra::Inverse)
        self.operator == operator && (self.x == x || x.nil?)
      elsif x.is_a?(Algebra::Inverse)
        self == x.x
      else
        false
      end
    end

    def formula?(operator)
      is_a?(Formula) && (@operator == operator)
    end

    Symbol.class_eval do
      def commutative?
        [:+, :*].include?(self)
      end
    end

    def ==(x)
      to_s == x.to_s
    end
  end
end
