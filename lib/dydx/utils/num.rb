module Dydx
  class Num
    # include Operator::Base
    # include Operator::Num
    # include Operator::General
    # include Operator::Interface
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
    eval("@n#{num} ||= Num.new(num)")
  end
end