module Dydx
  class Sin
    attr_accessor :x
    def initialize(x)
      @x = x
    end

    def to_s
      "sin( #{x.to_s} )"
    end

    # def d(sym=:x)
    #   cos(f) * f.d(sym)
    # end
  end

  def sin(x)
    if x == pi
      _(0)
    else
      Sin.new(x)
    end
  end
end