module Hilbert
  module Parser
    module SigmaParser
      include Base
      def self.execute(els)
        var, from, to, formula = els

        SigmaApi.execute(
          FormulaParser.execute(formula),
          var,
          from,
          to
        )
      end
    end
  end
end
