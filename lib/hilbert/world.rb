require 'hilbert/world/base'
require 'hilbert/world/propositional_logic'

module Hilbert
  module World
    class Entity
      @@propositions = []
      class << self
        def tautology
          @@propositions
        end

        def <<(logic_form)
          @@propositions << logic_form
        end

        def impl(logic_form, logic_str)
          # HOTFIX:
          return %|"Evaluate: #{logic_str} is UNDEFINED"| if @@propositions.empty?
          str = (!!!!!!!(@@propositions.inject(:*) >= logic_form)).to_s
          case str
          when 'TRUE'
            %|"Evaluate: #{logic_str} is TRUE"|
          when 'FALSE'
            %|"Evaluate: #{logic_str} is FALSE"|
          else
            %|"Evaluate: #{logic_str} is UNDEFINED"|
          end
        end

        def atom(sym)
          unless sym.to_s == sym.to_s.upcase && sym.to_s.length == 1
            raise 'Proposltionla variable should be capital character'
          end
          eval "$#{sym} ||= PropositionalLogic::Atom.new(:#{sym})"
        end

        def clear!
          @@propositions = []
        end
      end
    end
  end
end
