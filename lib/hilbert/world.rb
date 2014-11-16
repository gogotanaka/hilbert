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

        def <<(logic_str)
          @@propositions << to_rb_obj(logic_str)
          %|"Defined: #{logic_str} is TRUE"|
        end

        def impl(logic_str)
          # HOTFIX:
          return eval_rslt(logic_str, 'UNDEFINED') if @@propositions.empty?
          str = (!!!!!!!(@@propositions.inject(:*) >= to_rb_obj(logic_str))).to_s
          case str
          when 'TRUE'
            eval_rslt(logic_str, 'TRUE')
          when 'FALSE'
            eval_rslt(logic_str, 'FALSE')
          else
            eval_rslt(logic_str, 'UNDEFINED')
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

        def paradox?
          return %|"FALSE"| if @@propositions.empty?
          str = (!!!!!!!(@@propositions.inject(:*) >= (atom(:P) * ~atom(:P)))).to_s
          case str
          when 'TRUE'
            %|"TRUE"|
          else
            %|"FALSE"|
          end
        end

        # Internal Utils
        def to_rb_obj(logic_str)
          lexeds = Lexer::WorldLexer.execute(logic_str)
          Parser::WorldParser.execute(lexeds)
          eval Parser::WorldParser.parsed_srt
        end

        def eval_rslt(logic_str, rslt)
          %|"Evaluate: #{logic_str} is #{rslt}"|
        end

      end
    end
  end
end
