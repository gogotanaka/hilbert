module Dydx
  class Delta
    attr_accessor :var, :function
    def initialize(var = nil, function = nil)
      @var      = var
      @function = function
    end

    def /(delta)
      if var
        eval("$#{var}").differentiate(delta.var)
      elsif delta.function
        delta.function.differentiate(delta.var)
      end
    end
  end
end
