module Hilbert
  module Parser
    module LimitParser
      include Base
      def self.execute(els)
        var, close_to, formula = els

        LimitApi.execute(
          FormulaParser.execute(formula),
          var,
          close_to
        )
      end
    end
  end
end
