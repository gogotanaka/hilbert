require 'pry'
module Hilbert
  module Parser
    module SigmaParser
      include ::Hilbert::Api
      def self.execute(els)
        binding.pry
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
