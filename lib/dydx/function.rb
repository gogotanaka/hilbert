module Dydx
  class Function
    attr_accessor :algebra, :vars
    def initialize(*vars)
      @vars = vars
    end

    def <=(algebra)
      @algebra = algebra
      self
    end

    def differentiate(sym=:x)
      @algebra.differentiate(x)
    end
  end
end
