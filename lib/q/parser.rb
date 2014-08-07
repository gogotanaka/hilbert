require 'q/parser/base'
require 'q/parser/matrix_parser'
require 'q/parser/vector_parser'
require 'q/parser/list_parser'

require 'q/lexer/cont_lexer'

module Q
  module Parser
    def execute(lexed)

      loop do
        case lexed.token_str
        when /:LPRN\d(:CONT\d):RPRN\d/
          cont_token_with_num = $1
          cont_lexed = Lexer::ContLexer.new(lexed.get_value(cont_token_with_num))

          case cont_lexed.token_str
          when /(:NUM\d)+(:SCLN\d|:NLIN\d)(:NUM\d)/
            cont = MatrixParser.execute(cont_lexed)
            lexed.squash_with_prn(cont_token_with_num, cont)
          when /(:NUM\d)+/
            cont = VectorParser.execute(cont_lexed)
            lexed.squash_with_prn(cont_token_with_num, cont)
          end
        when /:LBRC\d(:CONT\d):RBRC\d/
          cont_token_with_num = $1
          cont_lexed = Lexer::ContLexer.new(lexed.get_value(cont_token_with_num))
          case cont_lexed.token_str
          when /(:OTHER\d:CLN\d(:STR\d|:NUM\d|:R\d):CMA)*(:OTHER\d:CLN\d(:STR\d|:NUM\d|:R\d))/
            cont = ListParser.execute(cont_lexed)
          end
        end

        if lexed.token_str =~ /(:CONT\d|:R\d)(:CONT\d|:R\d)/
          lexed.squash_to_cont($1, 2)
        end


      end

    end
    module_function :execute
  end
end
