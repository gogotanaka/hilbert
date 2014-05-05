module Dydx
  class Pi
    # include Operator::Base
    # include Operator::General
    # include Operator::Interface

    def d(sym=:x)
      _(0)
    end

    def to_s
      'π'
    end
  end

  def pi
    @pi ||= Pi.new
  end
end