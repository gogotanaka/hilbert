module Dydx
  module Helper
    def is_0?
      self == 0 || (is_a?(Num) && n == 0)
    end

    def is_1?
      self == 1 || (is_a?(Num) && n == 1)
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