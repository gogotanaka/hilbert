require 'hilbert/world/base'
require 'hilbert/world/propositional_logic'

module Hilbert
  module World
    class Entity
      @@tautology = []
      class << self
        def tautology
          @@tautology
        end

        def <<(logic_form)
          @@tautology << logic_form
        end

        def atom(sym)
          unless sym.to_s == sym.to_s.upcase && sym.to_s.length == 1
            raise 'Proposltionla variable should be capital character'
          end
          PropositionalLogic::Atom.new(sym)
        end
      end
    end
  end
end
