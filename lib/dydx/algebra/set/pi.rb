module Dydx
  module Field
    class Pi < Base
      def differentiate(sym=:x)
        _(0)
      end
      alias_method :d, :differentiate

      def to_s
        'pi'
      end
    end

    def pi
      @pi ||= Pi.new
    end
  end
end