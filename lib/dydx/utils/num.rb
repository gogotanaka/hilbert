require "dydx/operator/num"

require "dydx/helper"
module Dydx
  class Num
    include Operator::Num

    include Helper
    attr_accessor :n

    def initialize(n)
      @n = n
    end

    def d(sym=:x)
      _(0)
    end

    def to_s
      @n.to_s
    end
  end

  def _(num)
    if num >= 0
      eval("@p#{num} ||= Num.new(num)")
    else
      eval("@n#{-1 * num} ||= Num.new(num)")
    end
  end
end