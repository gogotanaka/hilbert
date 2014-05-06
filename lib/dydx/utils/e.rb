require "dydx/operator/general"

require "dydx/helper"

module Dydx
  class E
    include Operator::General

    include Helper

    def d(sym=:x)
      _(0)
    end

    def to_s
      'e'
    end
  end

  def e
    @e ||= E.new
  end
end