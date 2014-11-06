module Hilbert
  module Parser
    module IntegralParser
      include Base
      def execute(els)
        integrated, range = els[0], els[1]

        integrated.rm!(' ')

        IntegralApi.execute(FormulaParser.execute(integrated[0..-3]), integrated[-2..-1], range)
      end
      module_function :execute
    end
  end
end
