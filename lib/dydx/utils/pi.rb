require "dydx/operator/general"

module Dydx
  class Pi
    include Operator::General

    def d(sym=:x)
      _(0)
    end

    def to_s
      'pi'
    end
  end

  def pi
    @pi ||= Pi.new
  end
end