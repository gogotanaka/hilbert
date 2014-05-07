require "dydx/operator/general"

require "dydx/helper"

module Dydx
  class E
    include Operator::General

    include Helper

    def differentiate(sym=:x)
      _(0)
    end
    alias_method :d, :differentiate

    def to_s
      'e'
    end
  end

  def e
    @e ||= E.new
  end
end