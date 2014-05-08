module Dydx
  class Cos
    include Helper

    attr_accessor :x
    def initialize(x)
      @x = x
    end

    def to_s
      "cos( #{x.to_s} )"
    end

    def d(sym=:x)
      f.d(sym) / (f)
    end
  end

  def cos(x)
    multiplier = x.is_multiple_of(pi)
    if multiplier.is_a?(Num) && multiplier.n % 2 == 0
      _(1)
    elsif multiplier.is_a?(Num) && multiplier.n % 2 == 1
      _(-1)
    else
      Cos.new(x)
    end
  end
end