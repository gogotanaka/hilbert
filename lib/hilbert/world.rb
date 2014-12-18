require 'hilbert/world/base'
require 'hilbert/world/propositional_logic'

module Hilbert
  module World
    class Entity
      @@propositions = []
      class << self
        def <<(logic_str)
          @@propositions << to_rb_obj(logic_str)
          Messanger.define(logic_str)
        end

        def impl(logic_str)
          # HOTFIX: we need to ..
          return Messanger.evaluate(logic_str, 'UNDEFINED') if @@propositions.empty?

          logic = (@@propositions.inject(:*) >= to_rb_obj(logic_str))
          str = logic.dpll!.to_s
          case str
          when 'TRUE'  then Messanger.evaluate(logic_str, 'TRUE')
          when 'FALSE' then Messanger.evaluate(logic_str, 'FALSE')
          else
            logic = (@@propositions.inject(:*) >= (~to_rb_obj(logic_str)))
            str = logic.dpll!.to_s
            case str
            when 'TRUE'  then Messanger.evaluate(logic_str, 'FALSE')
            when 'FALSE' then Messanger.evaluate(logic_str, 'TRUE')
            else              Messanger.evaluate(logic_str, 'UNDEFINED')
            end
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
          return Messanger.tell_false if @@propositions.empty?

          case (!!!!!!!(@@propositions.inject(:*) >= (atom(:P) * ~atom(:P)))).to_s
          when 'TRUE' then Messanger.tell_true
          else             Messanger.tell_false
          end
        end

        # Internal Utils
        def to_rb_obj(logic_str)
          lexeds = Lexer::WorldLexer.execute(logic_str)
          Parser::WorldParser.execute(lexeds)
          eval Parser::WorldParser.parsed_srt
        end
      end

      module Messanger
        class << self
          def define(logic_str)
            %|"Defined: #{logic_str} is TRUE"|
          end

          def evaluate(logic_str, rslt)
            %|"Evaluate: #{logic_str} is #{rslt}"|
          end

          def tell_true
            %|"TRUE"|
          end

          def tell_false
            %|"FALSE"|
          end
        end
      end
    end
  end
end
