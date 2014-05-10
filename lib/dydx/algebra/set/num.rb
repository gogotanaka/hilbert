module Dydx
  module Field
    class Num < Base
      attr_accessor :n

      def initialize(n)
        @n = n
      end

      def differentiate(sym=:x)
        _(0)
      end
      alias_method :d, :differentiate

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
end