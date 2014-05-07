module Dydx
  class Cos
    attr_accessor :x
    def initialize(x)
      @x = x
    end

    def to_s
      "cos( #{x.to_s} )"
    end

    # def d(sym=:x)
    #   f.d(sym) / (f)
    # end
  end

  def cos(x)
    if x == pi
      _(-1)
    else
      Cos.new(x)
    end
  end
end