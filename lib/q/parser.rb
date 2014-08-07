require 'q/parser/base'
require 'q/parser/matrix_parser'
require 'q/parser/vector_parser'
require 'q/parser/list_parser'

require 'q/lexer/cont_lexer'

module Q
  module Parser
    def execute(lexed)

      case lexed.token_str
      when /:LPRN\d(:CONT\d):RPRN\d/
        main_lexed = Lexer::ContLexer.new(lexed.get_value($1))

        case main_lexed.token_str
        when /(:NUM\d)+(:SCLN\d|:NLIN\d)(:NUM\d)/
          MatrixParser.new(main_lexed)
        when /(:NUM\d)+/
          p 'v'
        end
      end
    end
    module_function :execute
  end
end
