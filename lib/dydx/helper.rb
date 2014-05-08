module Dydx
  module Helper
    def is_0?
      self == 0 || (is_a?(Num) && n == 0)
    end

    def is_1?
      self == 1 || (is_a?(Num) && n == 1)
    end

    def is_multiple_of(x)
      is_multiple = if self == x
        1
      elsif is_a?(Formula) &&
        (f == x || g == x)
        f == x ? g : f
      else
        false
      end
    end

    {
      addition:       :+,
      subtraction:    :-,
      multiplication: :*,
      division:       :/,
      exponentiation: :^
    }.each do |operator_name, operator|
      define_method("#{operator_name}?") { @operator == operator }
    end
  end
end