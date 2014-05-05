module Dydx
  class E
    # include Operator::Base
    # include Operator::General
    # include Operator::Interface

    def d(sym=:x)
      _(0)
    end

    def to_s
      'e'
    end
  end

  def e
    E.new
  end
end