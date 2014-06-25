module Dydx
  module Helper
    SUPER_OPE_RELATION = {
      :+ => :*,
      :- => :/,
      :* => :**,
      :/ => :|
    }

    INVERSE_OPE_RELATION = {
      :+ => :-,
      :- => :+,
      :* => :/,
      :/ => :*,
      :** => :|,
      :| => :**
    }

    def num?
      is_a?(Num) || is_a?(Numeric)
    end

    def to_numeric
      is_a?(Num) ? n : self
    end

    def zero?
      [0, 0.0].include?(self) || (is_a?(Num) && n.zero?)
    end

    def one?
      [1, 1.0].include?(self) || (is_a?(Num) && n.one?)
    end

    def minus1?
      [-1, -1.0].include?(self) || (is_a?(Num) && n.minus1?)
    end

    def distributive?(ope1, ope2)
      [ope1.super, ope1.inv_super].include?(ope2)
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
      when :**
        (num? && x.num?) || zero? || one?
      end
    end

    # TODO: Cyclomatic complexity for combinable? is too high. [9/6]
    def like_term?(x)
      self == x                         ||
      formula?(:*) && include?(x)       ||
      x.formula?(:*) && x.include?(self)||
      (formula?(:*) && formula?(:*) && !([f, g] & [x.f, x.g]).empty?)
    end

    # TODO: Cyclomatic complexity for combinable? is too high. [7/6]
    def multiple_of?(x)
      zero? ||
      self == x ||
      (num? && x.num? && self % x == 0) ||
      (formula?(:*) && (f == x || g == x))
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

      def associative?
        [:+, :*].include?(self)
      end

      def super
        SUPER_OPE_RELATION[self] || self
      end

      def sub
        SUPER_OPE_RELATION.invert[self] || self
      end

      def inv
        INVERSE_OPE_RELATION[self] || self
      end

      def inv_super
        self.super.inv
      end
    end

    def ==(x)
      to_s == x.to_s
    end

    # Refactor
    def **(x)
      self ** (x)
    end
  end
end
