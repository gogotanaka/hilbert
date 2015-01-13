module Hilbert
  module World
    class AxiomSystem
      @@axioms = []
      class << self
        def << (str)
          @@axioms << str
        end

        def axioms
          @@axioms
        end
      end
    end
  end
end
