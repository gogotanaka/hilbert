module Dydx
  module Field
    class E < Base
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
end