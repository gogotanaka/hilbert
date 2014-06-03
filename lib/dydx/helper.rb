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

    def inverse_ope(operator)
      INVERSE_OPE_RELATION[operator]
    end

    def inverse_super_ope(operator)
      inverse_ope(operator.super)
    end

    def num?
      (is_a?(Num) || is_a?(Fixnum) || is_a?(Float)) || (is_a?(Inverse) && x.num?)
    end

    def zero?
      [0, 0.0].include?(self) || (is_a?(Num) && n.zero?)
    end

    def one?
      [1, 1.0].include?(self) || (is_a?(Num) && n.one?)
    end

    def is_minus1?
      [1, -1.0].include?(self) || (is_a?(Num) && n.is_minus1?)
    end

    def distributive?(ope1, ope2)
      [ope1.super, ope1.inverse_super].include?(ope2)
    end

    # TODO: Cyclomatic complexity for combinable? is too high. [17/6]
    def combinable?(x, operator)
      case operator
      when :+
        (num? && x.num?) ||
        (formula?(:*) && (f.num? || g.num?)) && x.num? ||
        like_term?(x) ||
        inverse?(:+, x)
      when :*
        self == x ||
        (num? && x.num?) ||
        inverse?(:*, x)
      when :^
        (num? && x.num?) || zero? || one?
      end
    end

    # TODO: Cyclomatic complexity for combinable? is too high. [9/6]
    def like_term?(x)
      boolean = if self == x
                elsif formula?(:*) && include?(x)
                elsif x.formula?(:*) && x.include?(self)
                elsif (formula?(:*) && formula?(:*)) && (([f, g] & [x.f, x.g]).any? { |x| x.is_a?(Symbol) })
                else
                  true
                end

      !boolean
    end

    # TODO: Cyclomatic complexity for combinable? is too high. [7/6]
    def is_multiple_of(x)
      if zero?
        e0
      elsif self == x
        e1
      # elsif num? && x.num? && (self % x == 0)
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

    def distributable?(_operator)
    end

    def inverse?(operator, x = nil)
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

      def super
        SUPER_OPE_RELATION[self] || self
      end

      def sub
        SUPER_OPE_RELATION.invert[self] || self
      end

      def inverse_super
        inverse_super_ope(self) || self
      end
    end

    def ==(x)
      to_s == x.to_s
    end

    # Refactor
    def **(x)
      self ^ (x)
    end
  end
end
