require 'hilbert/lexer/formula_lexer'

module Hilbert
  module Parser
    module FormulaParser
      include Lexer::Tokens

      def self.execute(str)
        lexed = Lexer::FormulaLexer.new(str)
        time = Time.now
        loop do
          fail "I'm so sorry, something wrong. Please feel free to report this. [DEBUGG CODE31]" if Time.now > time + 10
          case lexed.token_str
          when /:EXP(\d+)/
            new_ope = $meta_info.lang == :ruby ? '**' : '^'
            lexed.parsed!(new_ope, $1)
          when /:MUL(\d+)/
            sss = StringScanner.new(lexed.get_value($1))
            ary = []
            until sss.eos?
              [/pi/, /[1-9a-z]/].each do |rgx2|
                ary << sss[0] if sss.scan(rgx2)
              end
            end
            parsed = ary.join(' * ')

            lexed.parsed!(parsed, $1)
          else
            break
          end
        end
        lexed.values.join
      end
    end
  end
end
